const { CognitoJwtVerifier } = require("aws-jwt-verify");

const APP_CLIENT_IDS = [process.env.COGNITO_APP_CLIENT_ID_MACHINE];

const cognitoVerifier = CognitoJwtVerifier.create({
    userPoolId: process.env.COGNITO_USER_POOL_ID,
    tokenUse: "access",
    clientId: APP_CLIENT_IDS,
});

const generatePolicy = (principalId, effect, resource) => {
    const authResponse = {};
    authResponse.principalId = principalId;
    if (effect && resource) {
        const policyDocument = {
            Version: "2012-10-17",
            Statement: [
                {
                    Action: "execute-api:Invoke",
                    Effect: effect,
                    Resource: resource,
                },
            ],
        };
        authResponse.policyDocument = policyDocument;
    }
    return authResponse;
};

exports.handler = async (event) => {
    console.log("Authorizer event received:", JSON.stringify(event, null, 2));

    const token = event.authorizationToken;
    if (!token) {
        console.log("Authorization token missing.");
        // The API Gateway converts this to a 401 Unauthorized
        return generatePolicy("user", "Deny", event.methodArn);
    }

    // Tries to extract the JWT. Expects 'Bearer <token>'.
    const parts = token.split(" ");
    if (parts.length !== 2 || parts[0].toLowerCase() !== "bearer") {
        console.log("Malformed token. Should be 'Bearer <token>'.");
        return generatePolicy("user", "Deny", event.methodArn);
    }

    try {
        const jwt = parts[1];
        const payload = await cognitoVerifier.verify(jwt);
        console.log("Token is valid. Payload:", payload);

        const tmp = event.methodArn.split(":");
        const apiGatewayArnPart = tmp[5].split("/");
        const region = tmp[3];
        const awsAccountId = tmp[4];
        const apiId = apiGatewayArnPart[0];
        const stage = apiGatewayArnPart[1];

        const wildcardResource = `arn:aws:execute-api:${region}:${awsAccountId}:${apiId}/${stage}/*/*`;

        return generatePolicy(
            payload.sub || payload.client_id,
            "Allow",
            wildcardResource
        );
    } catch (err) {
        console.error("Invalid token:", err);
        return generatePolicy("user", "Deny", event.methodArn);
    }
};
