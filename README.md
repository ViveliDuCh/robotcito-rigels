# robotcito-rigels
robotcito uwu 


Notas pa la progra Vivi:
La gui incrementará los valores de cada theta
en 1 resolución (1023/300 o viceversa) por cada click del usuario
Dependiendo si se quiere mover la base o cualquiera de los demás motores
Habrán las flechas pertinentes para cada motor, que ayudarán a incrementar o disminuir cada valor
ya dependiendo del set de flechas que el usuario elija en la GUI
Sabremos a qué motor, qué ID usar, le mandamos la info, qué theta es 1,2 o 3

Igual, luego de que eso jale, pensaba añadir campos para que se pueda mandar thetas específicos 
Algo que el programa que tenemos ya soporta
porque espera que se le manden 3 valores específicos, toda esa interacción se hará a través de la GUI


NOTA: El Arduino debe tener cargado ya el programa que recibe los thetas y hace que se mueva el dynamixel
Lo de saber qué motor mover y demás, se hace en matlab pues cada theta1-2-3 es para un motor en específico.

En el programa de arduino solo hay que asegurarnos de que el theta correspondiente mueva el motor del ID que esperamos.

ex. 
theta 1, move (theta1, ID1)
theta 2, move (theta2, ID2)
theta 3, move (theta3, ID3)
