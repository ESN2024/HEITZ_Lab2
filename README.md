# HEITZ_Lab2

## **I. Introduction :**

Ce rapport a pour but de présenter le travail effectué lors des travaux pratiques de l'UE Conception Conjointe, visant à approfondir et à mettre en œuvre nos connaissances via la mise en place d'une architecture NIOS nous permettant ici de coder un compteur BCD en C. Pour ce faire, le cahier des charges était simple. En se basant sur la plate-forme DE-10 embarquant un FPGA Max-10, il nous était demandé de créer le compteur BCD affichant le décompte en hexadécimal sur 3 afficheurs 7 segments. Le compteur sera incrémenté chaque seconde via une interruption généré par un Timer.

## **II. Architecture :**

De ce cahier des charges nous en déduisons par la suite l'architecture à mettre en place sur plate-forme designer. Le schéma ci-dessous vous présente mon choix :

![image](https://github.com/ESN2024/HEITZ_Lab2/blob/main/lab_2_archi.jpg)

Pour aller plus loin, on peut ajouter que le CPU est un NIOS II lite, ou encore que le bus LED a une taille de 8 bits, le bus switch 4 bits. La clock choisie pour cadencer toute l'architecture sera la 50 MHz de la DE10. Une fois le fichier VHDL généré et le design compilé, j'ai affecté les différents pins de mon design aux I/O de la DE-10 via le Pin Planner de Quartus. Il est important de noter qu'ici le JTAG UART a pour vocation d'aider au débogage de l'application via l'utilisation de la console NIOS II.

Comme vous pouvez le voir, le bus reliant les 7 segments au Pio de sortie est un bus de 12 bits. Ainsi, il me permet de ne pas avoir besoin d'utiliser un système de type double dable pour compter en hexadécimal.

### **a. Architecture du projet :

Pour ce lab, nous rajoutons un nouvel aspect à la conception. En effet, nous souhaitons créer une IP VHDL pour le décodeur 7 segments que nous utiliseront pour décoder la sortie de l'architecture NIOS. Ainsi, il nous faut d'un côté designer le système NIOS et de l'autre créer notre IP segdecod.vhdl. Une fois, ceci fait, nous utilisons un fichier top level nous permettant de faire le lien entre les deux entités (CF : Lab_2_top.vhd).

## **III. Design du code C :**

Nous arrivons maintenant à l'essence même du TP. Les avantages d'utiliser une architecture NIOS consistent à nous permettre de nous affranchir du VHDL en codant notre application via un code en C qui mettra en œuvre la dynamique de notre système, pouvant être composé de différentes IP VHDL bien évidemment. Cependant, la partie opérative sera effectuée en C. Ainsi, cela nous permet de rester sur un raisonnement séquentiel classique, nous permettant de coder plus aisément.

Rappelons le but du TP : nous souhaitons afficher sur 3 décodeurs 7 segments, un compteur BCD s'incrémentant toutes les secondes via l'interruption générée par le Timer de l'architecture NIOSII

Ainsi, nous actualiserons au sein d'une boucle while infinie le compteur en envoyant directement la valeur 12 bits en entrée des trois décodeurs. Ceci permet de ne pas avoir à faire 3 us différents et de ne pas utiliser un double dable. L'incrémentation de la variable volatile compteur se fera dans la fonction Time handler déclenché par l'interruption périodique généré par le timer. Pour ce faire, il nous faut initialiser le timer et l'interruption.

## **IV. Conclusion**

Ce TP est une bonne entrée en matière me permettant de mettre en œuvre un TImer, le design d'une architecture à base de Nios, le lien entre un IP crée par nos soin et un fichier top level et implémentation d'un code C sur celle-ci.
Vous pouvez retrouver une vidéo démontrant mon système :
