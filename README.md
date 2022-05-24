# MyGame

## Grupo
- PA - PA038TIN1
- Mobile - CP110TIN1
- Ari Tedeschi Junior - 190075
- Joel Ribeiro B. Junior - 190304
- Matheus H. G. da Silva - 190038
- Rafael R. Rodrigues - 190320
- Vinicius A. Barbosa - 180326

## Funcionalidades
O Aplicativo trata-se de um fórum de de assuntos realacionados a jogos. Utilizou-se localização de linguagem em PT(Portugês) e EN(Inglês). O projeto foi configurado para utilizar das funcionalidades do Firebase (Autenticação, Banco de dados, etc). A seguir a explicação da utilidade de cada tela.

### Loading
Essa tela valida se o usuário está autenticado e caso esteja redireciona para a página **Home**, caso não esteja redireciona para a 'Landing Page' para o usuário conseguir realizar o Login.

<p align="center">
  <img src="https://user-images.githubusercontent.com/70178202/170049927-86d9f085-92be-47af-a58c-e93e28a55229.png">
</p>

### Landing Page
Essa tela possui os dados dos integrantes do grupo, dois botões de login, sendo um de login por email, no qual o usuário será redirecionado para a página de **Login**, e outro botão de login por google, aonde o usuário será autenticado pela conta google e redirecionado para a página **Home**. Ambas as autenticações são feitas por Firebase.

<p align="center">
  <img src="https://user-images.githubusercontent.com/70178202/170050681-c52b5675-adad-455c-9274-35f389dc8265.png">
</p>

### Login Page
Essa tela será responsável por logar o usuário por email e senha, utilizando autenticação Firebase. Além disso, possui embaixo um botão para redirecionar para a página de **Cadastro** caso o usuário ainda não possua usuário. Se for o primeiro login do usuário, ele será redirecionado para tela de **Seleção de Usuário**.

<p align="center">
  <img src="https://user-images.githubusercontent.com/70178202/170055190-84a7dcd2-f912-46be-880f-d4956075ebb4.png">
</p>

### Register Page
Essa tela será responsável pelo cadastro de um novo usuário. Será solicitado: Nome, Sobrenome, Email, e Senha. Após preenchido e validado os dados, o usuário será redirecionado para a Página de **Login**.

<p align="center">
  <img src="https://user-images.githubusercontent.com/70178202/170057228-e8f0ffb4-55c7-4347-973a-253140eae052.png">
</p>

### User Page
Essa tela será responsável por adicionar o Usuário de uma conta realizando o primeiro login na plataforma.

<p align="center">
  <img src="https://user-images.githubusercontent.com/70178202/170058261-87f3caa5-f97b-402f-8033-d1c92ec78115.png">
</p>

### Home Page - Em desenvolvimento
Essa tela irá apresentar um Dashboard com todos os jogos que possuem um forum na plataforma, possuirá uma navbar com o user do usuario, a possibilidade de acesasr a tela de **Perfil** e também realizar o Log out.

### Profile Page - Em desenvolvimento
Na tela de perfil será possível visualizar e alterar todos os dados da conta, sendo eles: Nome, Sobrenome, Usuário, Email e Senha.

### Game Page - Em desenvolvimento
Essa tela irá possuir o forúm com todos os posts dos usuários relacionado ao Jogo, podendo possuir postagens de humor, dicas, vazamentos, novidades, entre muitas outras. Será possível realizar comentários nos posts também.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
