%% Punto 3.a
load Heart.mat
Edad=heart_data.age;
Edad=Edad/365;
%% Punto 3.B
AF=heart_data.active;%Se extrae unicamente la parte de la tabla que indica actividad fis
T=size(Edad,1);%En T meto la varible de el numero de filas
Af=strings(T,1);%Creo una matriz de 70000 sin datos para poder escribir si Hace ejercicio o no
Sm=strings(T,1);%Creo una matriz de 70000 sin datos para poder escribir si fuma o no
for i= 1:T %Un for para ir de la primera fila a la 70000 y asi poder preguntar si cada persona hace ejercico o no
    if heart_data.active(i) ==0 
        Af(i)="No hace ejercicio"; 
    else 
        Af(i)="Hace ejercicio";
    end
end
heart_data.Haceejercicio=Af; %Se crea una nueva columna y se coloca si hace o no
for i= 1:T
    if heart_data.smoke(i) ==0
        Sm(i)="No fuma";
    else 
        Sm(i)="Si fuma";
    end
end
heart_data.Fuma=Sm; %Se repite pero en este caso si fuma o no
%% Punto 3.c
Altura=heart_data.height;
Peso=heart_data.weight;
Altura=Altura/100;
Altura=Altura.*Altura;
imc=Peso./Altura;
Imc=strings(T,1);
for i= 1:T
    if imc(i)<18.5
        Imc(i)="Esta bajo de peso";
    elseif 18.5<=imc(i) && imc(i)<=25
        Imc(i)="Tiene un peso adecuado";
    else 
        Imc(i)="Tiene sobrepeso";
    end
end
heart_data.IMC=Imc;
%% Punto 3.d
Sis=heart_data.ap_hi;
Dias=heart_data.ap_lo;
Ap=Sis-Dias/3;
Ap=Ap+Dias;
heart_data.presionarterialmedia=Ap;
%% Punto 5
figure(1)
Hombresmen=0;
Mujeresmen=0;
Hombresmay =0;
Mujeresmay=0;
PC=heart_data.cardio;
Gen=heart_data.gender;
for i= 1:T %%Menores
     if Edad(i)>50 && PC(i)==1 && Gen(i) ==1
        Hombresmen=Hombresmen+1;
     elseif Edad(i)>50 && PC(i)==1 && Gen(i)==2
        Mujeresmen=Mujeresmen+1;
     end
end
for i= 1:T %%Mayores
     if Edad(i)<50 && PC(i)==1 && Gen(i) ==1 
        Hombresmay=Hombresmay+1;
     elseif Edad(i)>50 && PC(i)==1 && Gen(i)==2
        Mujeresmay=Mujeresmay+1;
     end
end


x=["Menores de 50 años", "Mayores de 50 años" ];
y=[Hombresmen Mujeresmen ; Hombresmay Mujeresmay];
bar(x,y)
title("Hombres y mujeres con problemas cardiacos")
legend("Hombres","Mujeres")
xlabel("Rangos de edades")
ylabel("Personas con PC")
%% Punto 6 
figure(2)
Col=heart_data.cholesterol;
Gluc=heart_data.gluc;
tiledlayout(2,1)
nexttile
gscatter (imc,Col)
title("Grafica de Imc vs Colesterol")
xlabel("Indice de masa corporal")
ylabel("Niveles de colesterol")
nexttile
gscatter (Gluc,Ap)
title("Grafica de Glucosa vs Presion arterial media")
xlabel("Nivel de glucosa")
ylabel("Presion arterial media")%Falta separarlos de con y sin problemas
%% Punto 7
Con=Hombresmay+Hombresmen+Mujeresmay+Mujeresmen;
Sin=T-Con;
%% 7.a (IMC) Con
Imccon=0;
for i= 1:T 
     if PC(i)==1 
        Imccon=Imccon+imc(i);
     else
        Imccon;
     end
end
mediaImc=Imccon/Con;

disp ("La media de IMC de personas con problemas cardiacos es de "+ mediaImc) 

Imccuadrada=(imc-mediaImc);
Imccuadrada=Imccuadrada.*Imccuadrada;
Imcsuma=0;
for i= 1:T 
    
    Imcsuma=Imcsuma+Imccuadrada(i);
    
end
Desestandar=Imcsuma/Con;
disp ("La desviacion estandar de IMC de personas con problemas cardiacos es de "+Desestandar)
%% 7.a (IMC) Sin
Imcsin=0;
for i= 1:T 
     if PC(i)==0 
        Imcsin=Imcsin+imc(i);
     else
        Imcsin;
     end
end
mediaImcsin=Imcsin/Sin;
disp ("La media de Imc de personas sin problemas cardiacos es de  "+mediaImcsin)
imccuadrada=(imc-mediaImcsin);
imccuadrada=imccuadrada.*imccuadrada;
imcsum=0;
for i= 1:T 
    imcsum=imcsum+imccuadrada(i);
end
desestandar=imcsum/Sin;
disp ("La desviacion estandar de IMC de personas sin problemas cardiacos es de "+desestandar)
%% 7.b PAM (Presión arterial media) Con
Pam=0;
for i= 1:T 
     if PC(i)==1 
        Pam=Pam+Ap(i);
     else
        Pam;
     end
end
Media=Pam/Con;
disp ("La media de PAM de personas con problemas cardiacos es de  "+Media)
cuadrada=(Ap-Media);
cuadrada=cuadrada.*cuadrada;
Pamsum=0;
for i= 1:T 
    Pamsum=Pamsum+cuadrada(i);
end
desestandar=Pamsum/Con;
disp ("La desviacion estandar de PAM de personas con problemas cardiacos es de "+desestandar)
%% 7.b PAM Sin
Pam=0;
for i= 1:T 
     if PC(i)==0
        Pam=Pam+Ap(i);
     else
        Pam;
     end
end
Media=Pam/Sin;
disp ("La media de PAM de personas Sin problemas cardiacos es de  "+Media)
cuadrada=(Ap-Media);
cuadrada=cuadrada.*cuadrada;
Pamsum=0;
for i= 1:T 
    Pamsum=Pamsum+cuadrada(i);
end
desestandar=Pamsum/Sin;
disp ("La desviacion estandar de PAM de personas sin problemas cardiacos es de "+desestandar)
%% 7.c Colosterlor Con
Pam=0;
for i= 1:T 
     if PC(i)==1
        Pam=Pam+Col(i);
     else
        Pam;
     end
end
Media=Pam/Con;
disp ("La media del nivel de colesterol de personas con problemas cardiacos es de  "+Media)
cuadrada=(Col-Media);
cuadrada=cuadrada.*cuadrada;
Pamsum=0;
for i= 1:T 
    Pamsum=Pamsum+cuadrada(i);
end
desestandar=Pamsum/Con;
disp ("La desviacion estandar del nivel de colesterol de personas con problemas cardiacos es de "+desestandar)
%% 7.c Colesterol Sin
Pam=0;
for i= 1:T 
     if PC(i)==0
        Pam=Pam+Col(i);
     else
        Pam;
     end
end
Media=Pam/Sin;
disp ("La media del nivel de colesterol de personas sin problemas cardiacos es de  "+Media)
cuadrada=(Col-Media);
cuadrada=cuadrada.*cuadrada;
Pamsum=0;
for i= 1:T 
    Pamsum=Pamsum+cuadrada(i);
end
desestandar=Pamsum/Sin;
disp ("La desviacion estandar del nivel de colesterol de personas sin problemas cardiacos es de "+desestandar)
%% Punto 8
Num= input("Ingrese el ID del participante");
 disp ("El participante numero "+Num+" Tiene las siguientes caracteristicas:")
if PC(Num)==0
   disp ("-No tiene problemas cardiacos")
else
    disp ("-Tiene problemas cardiacos")
end
if heart_data.smoke(Num) ==0
        disp ("-No fuma");
else 
        disp ("-Si fuma");
end
if heart_data.alco(Num) ==0
        disp ("-No Toma alcohol");
else 
        disp ("-Si Toma alcohol");
end
if heart_data.active(Num) ==0
        disp ("-No hace ejercicio");
else 
        disp ("-Si hace ejercicio");
end
if imc(Num)<=18.5
        disp ("Esta bajo de peso");
    elseif 18.5<=imc(i) && imc(i)<=25
        disp ("Tiene un peso adecuado");
    else 
        disp ("Tiene sobrepeso");
    end