# MyGame

## Grupo
- PA - PA038TIN1
- Mobile - CP110TIN1
- Ari Tedeschi Junior - 190075
- Joel Ribeiro B. Junior - 190304
- Matheus H. G. da Silva - 190038
- Rafael R. Rodrigues - 190320
- Vinicius A. Barbosa - 180326

## Configurando o Ambiente
Para executar o projeto em uma máquina, é necessário ter instalado algumas dependências, dentre elas:
- Git - https://git-scm.com/downloads
- Android Studio - https://developer.android.com/studio/install?hl=pt-br
- Flutter - https://docs.flutter.dev/get-started/install

Após realizada a instalação das dependências acima, entre em seu Android Studio e realize algumas outras configurações:

- Nas Configurações, selecione Plugins e instale os plugins para o Dart e o Flutter:

![image](https://user-images.githubusercontent.com/62195177/170169958-a24a3940-c833-4d6f-b490-f51465b3d8f6.png)


- Acesse o SDK Manager:

![image](https://user-images.githubusercontent.com/62195177/170168374-210de603-78b6-4fee-9516-18708ad73e6b.png)


- Escolha uma versão do Android que será baixada para ser emulada em sua máquina. No exemplo, será usado o Android 8.1 (Oreo):

![image](https://user-images.githubusercontent.com/62195177/170168524-45c866a9-5e2d-4bce-b136-b2285e574f05.png)


- Verifique as configurações para o SDK Tools:

![image](https://user-images.githubusercontent.com/62195177/170168782-4e8abee1-6fc0-4d42-bab8-f8d30e9412fb.png)
Após as configurações, alguns termos do Google podem ser solicitados e aceitos para que o Download prossiga. Aceite e espere até que tudo esteja instalado.


- Em seguida, vá ao Device manager para criar um dispositivo virtual:

![image](https://user-images.githubusercontent.com/62195177/170169073-2b052063-b651-4019-877a-6ef06636b15b.png)


- Selecione um Device que será virtualizado em seu sistema e o sistema android que rodará nele:

![image](https://user-images.githubusercontent.com/62195177/170169290-0cbc9d8e-7de4-4289-bb29-7af3735f4478.png)

![image](https://user-images.githubusercontent.com/62195177/170169436-74d7c0e4-f36e-4827-bb5f-08aa40c2af5d.png)


- Insira um nome para a máquina virtual e em finalizar:

![image](https://user-images.githubusercontent.com/62195177/170169533-f12b2420-1da0-4d40-9f97-0a3259b5a06b.png)


- Selecione a máquina virtual para ser aberta:

![image](https://user-images.githubusercontent.com/62195177/170170104-aa87bfb4-37ff-4ec2-af62-a78a5a44a609.png)


- Execute o main.dart:

![image](https://user-images.githubusercontent.com/62195177/170170223-b2640077-3c9c-4ada-a0ac-d92571bfacf6.png)

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