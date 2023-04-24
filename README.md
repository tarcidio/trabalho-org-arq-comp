# Trabalho SCC0902 Organização e Arquitetura de Computadores:

## Autores:

* Tarcídio Antônio Júnior - 10748347
* Jade Bortot de Paiva - 11372883
* Gabriel Barbosa de Oliveira - 12543415
* Vamo -

## Introdução

  A disciplina de Organização e Arquitetura de Computadores é crucial para estudantes e profissionais de tecnologia da informação. Ela oferece uma compreensão sólida do funcionamento interno dos computadores e seus componentes, sendo fundamental para o desenvolvimento de softwares e hardwares eficientes capazes de executar operações complexas de forma rápida e precisa. Além disso, o estudo dessa disciplina também ajuda a solucionar problemas em sistemas computacionais, identificando falhas de desempenho e segurança e encontrando soluções apropriadas.

## Objetivo do trabalho
  
  Nesse contexto, este trabalho tem como objetivo praticar inúmeros conceitos da disciplina, desenvolvendo habilidades em programação e entendendo melhor o funcionamento interno de estruturas de dados importantes para o desenvolvimento de softwares eficientes e de alta qualidade. Neste trabalho, é implementado, em Assembly RISC-V, uma lista ligada. Ela armazena duas informações: um ID (inteiro - 4 bytes) e uma string de tamanho fixo de 28 caracteres (28 bytes).

## Ferramentas

  Para elaboração, utilizou-se o simulador RARS (versão 1.5) para a linguagem Assembly RISC-V

## Testes

### Zero elementos

![image](https://user-images.githubusercontent.com/50781629/233849077-8eeb68aa-4037-4bea-bece-7edbce898b01.png)

### Um elemento

![image](https://user-images.githubusercontent.com/50781629/233848818-0ae537c9-fd58-401c-8296-1b89fd1d6e60.png)

### Dois elementos

![image](https://user-images.githubusercontent.com/50781629/233848849-f00752e5-2e64-4125-b475-22f5ad61b789.png)

### Cinco elementos

![image](https://user-images.githubusercontent.com/50781629/233848904-e6588926-c1b3-4001-82e0-e7560476e22f.png)

### Dez elementos

![image](https://user-images.githubusercontent.com/50781629/233849037-75caa777-a423-428a-8b56-13dcb1bcb4c8.png)
![image](https://user-images.githubusercontent.com/50781629/233849051-a803230a-954b-4c29-87f6-d45913f28d0e.png)

### Valor menor que zero

![image](https://user-images.githubusercontent.com/50781629/233849324-10a63ec7-1d67-4005-b81f-1c7d28221303.png)

### String com mais de 28 caracteres

![image](https://user-images.githubusercontent.com/50781629/233849876-cdaac958-28c7-40b5-8263-965c4e5a83af.png)

## Desafios
  Via de regra, o trabalho foi a aplicação do que foi muito bem ensinado já em sala de aula. Portanto, os desafios foram pontuais. O primeiro deles foi a utilização da chamada ao sistema para alocação de memória que até então não se tinha usado. O segundo desafio foi separar o código em funções. Este levou mais tempo, pois foi necessário revisitar o código após uma semana e isso fez com que o grupo se esquecesse, mesmo com os devidos comentários, do que cada comando no código fazia. Por fim, o grupo também tentou separar as funções em um arquivo a parte para incluí-lo depois, mas não foi possível, pois o simulador não permite. 

---

<sup>Instituto de Ciências Matemáticas e de Computação (ICMC) - Universidade de São Paulo (USP)</sup>

