# Baiter's Burger - Infraestrutura de Produtos

Este repositório abriga a infraestrutura como código (IaC) para o serviço de gerenciamento de produtos do Baiter's Burger, totalmente construída na AWS e gerenciada com o Terraform.

## Tecnologias

-   **Terraform:** Para provisionar e gerenciar a infraestrutura como código.
-   **Docker:** Para criar contêineres da aplicação.
-   **Node.js:** Utilizado na função Lambda para o autorizador de JWT.
-   **AWS:** A plataforma de nuvem que hospeda todos os serviços.

## Arquitetura

A arquitetura foi desenhada para ser escalável e segura, utilizando os seguintes serviços da AWS:

-   **Amazon RDS:** Um banco de dados MySQL é provisionado para persistir os dados dos produtos. As credenciais são gerenciadas de forma segura pelo AWS Secrets Manager.
-   **Amazon ECR & ECS:** As imagens Docker da aplicação são armazenadas no ECR e orquestradas em um cluster ECS, garantindo alta disponibilidade e escalabilidade.
-   **Amazon ELB:** Um Application Load Balancer distribui o tráfego de entrada para os serviços no ECS, otimizando a performance e a resiliência.
-   **AWS Lambda:** Uma função Lambda atua como autorizador para o ELB, validando tokens JWT emitidos pelo Amazon Cognito antes de permitir o acesso à API.
-   **Amazon Cognito:** Gerencia a autenticação e autorização de clientes, que obtêm tokens para interagir de forma segura com a API de produtos.
-   **Amazon CloudWatch:** Monitora a performance da infraestrutura com alertas configurados para a utilização de CPU do RDS, notificando a equipe via Amazon SNS.

## Repositórios relacionados

Este repositório provisiona a infraestrutura principal para os seguintes serviços:

-   **[Baiter's Burger - Aplicação de Produtos](https://github.com/lucasnabeto/baiters-burger-products-app):** A aplicação principal que consome a infraestrutura de banco de dados e contêineres.
-   **[Baiter's Burger - API Gateway de Produtos](https://github.com/lucasnabeto/baiters-burger-products-api-gateway):** O gateway de API que utiliza o autorizador Lambda e o balanceador de carga para expor a API de produtos.

## Guia de uso

### Pré-requisitos

-   Terraform instalado.
-   Credenciais da AWS configuradas em seu ambiente.

### Provisionando a infraestrutura

1. **Inicialize o Terraform:**

    ```bash
    terraform init
    ```

2. **Planeje as alterações:**

    ```bash
    terraform plan
    ```

3. **Aplique as alterações:**
    ```bash
    terraform apply
    ```

### Removendo a infraestrutura

Para remover todos os recursos criados, execute:

```bash
terraform destroy
```
