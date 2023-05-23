function [T,MatrizParcial,MatrizInterm] = GENDGM(sigma,a,alpha,d,theta,q)
   % clc
    %close all
%   Variables Analizadas
    [n1,n2]=size(sigma);          %Sigma es la varialbe que determina si es una union de rotacion(0) o traslacion(1)
    [n3,n4]=size(a);              %Distancia entre zi-1 y zi sobre xi
    [n5,n6]=size(alpha);          %Angulo entre zi-1 y zi alrededor de xi
    [n7,n8]=size(d);              %distancia entre origen Ri-1 y punto donde xi y zi intersectan
    [n9,n10]=size(theta);         %Angulo entre xi-1 y xi alrededor de zi-1
    [n11,n12]=size(q);            %Valor sobre el cual se quiere calcular

%     %Variables para dividir las posiciones de cada junta y graficar
%     X{1} = 0;
%     Y{1} = 0;
%     W{1} = 0;
%     ans = 1; % Matriz unitaria
    
%   Codigo

%Esta parte se encarga de guardar columnas y filas, y permite que cada
%tipo de entrada si desea almacenar "columna X filas" o "fila X columna" esto solo
%compara el valor que sea mayor para que organizarlo según el mayor.

    if(n1<n2)
        sigma=transpose(sigma);
    end
    if(n3<n4)
        a=transpose(a);
    end
    if(n5<n6)
        alpha=transpose(alpha);
    end
    if(n7<n8)
        d=transpose(d);
    end
    if(n9<n10)
        theta=transpose(theta);
    end
    if(n11<n12)
        q=transpose(q);
    end

    if (length(sigma)==length(a))&&(length(sigma)==length(alpha))&&(length(sigma)==length(d))&&(length(sigma)==length(theta))&&(length(sigma)==length(q))
        j=1;
        while (j<length(sigma)+1)
            if(sigma(j,1)==0)
                theta(j,1)=theta(j,1)+ q(j,1);
            elseif (sigma(j,1)==1)
                d(j,1)=q(j,1)+d(j,1);
            end
            j=j+1;
        end
        j=1;
        while j<length(sigma)+1
            if (j==1)
                j;
                T=rotZaxis(theta(j,1))*transZaxis(d(j,1))*rotXaxis(alpha(j,1))*transXaxis(a(j,1));
                MatrizParcial=T;
                %MatrizInterm=T;
                MatrizInterm(:,:,j)= T;
                %Datos para graficar

%                 X=T(1,4);
%                 Y=T(2,4);
%                 Z=T(3,4);
                
%                 X{j+1} = T(1,4);
%                 Y{j+1} = T(2,4);
%                 Z{j+1} = T(3,4);
                
                %view(3); %para que grafique 3D
                %line([x{j},x{j+1}],[y{j},y{j+1}],[w{j},w{j+1}],'marker','*','Color','blue','linewidth',2)
                %graph = line([x{j},x{j+1}],[y{j},y{j+1}],[w{j},w{j+1}]);  %line(x,y,z)
                %graph.Color = 'blue';
                %graph.LineWidth = 2;
                %graph.Marker = '*';
            else
                j;
                %Matriz parcial es 0T1-1T2-2T3
                MatrizParcial=[MatrizParcial rotZaxis(theta(j,1))*transZaxis(d(j,1))*rotXaxis(alpha(j,1))*transXaxis(a(j,1))]; 
                T=T*(rotZaxis(theta(j,1))*transZaxis(d(j,1))*rotXaxis(alpha(j,1))*transXaxis(a(j,1)));
                %Matriz intermedia es 0T1-0T2-0T3 
                %*siempre con la referenca*
                %MatrizInterm=[MatrizInterm T];
                MatrizInterm(:,:,j)= T; %Esta es la parte que guarda las matrices
                %ans * T;
                %V{j}=ans; % Separacion de los Datos de posicion de la Matriz y plot
                %Datos para graficar
%                 X=[X T(1,4)];
%                 Y=[Y T(2,4)];
%                 Z=[Z T(3,4)];
                %X(:,:,j)= T(1,4);   
                %Y(:,:,j)= T(2,4);
                %Z(:,:,j)= T(3,4);
                

%                 view(3); %pa que grafique en 3 dimensiones
%                 %line([x{j},x{j+1}],[y{j},y{j+1}],[w{j},w{j+1}],'marker','*','Color',[rand, rand,rand],'linewidth',2)   
%                 %graph = line([x{j},x{j+1}],[y{j},y{j+1}],[w{j},w{j+1}],'marker','*','Color','blue','linewidth',2)     
%                 graph = line([x{j},x{j+1}],[y{j},y{j+1}],[w{j},w{j+1}]);  %line(x,y,z)
%                 graph.Color = 'blue';
%                 graph.LineWidth = 2;
%                 graph.Marker = '*';
                
            end
            j=j+1;
        end
%        junta1x=V{1}(1,4)
%        junta1y=V{1}(2,4)
%        junta1z=V{1}(3,4)
%        junta2x=V{2}(1,4)
%        junta2y=V{2}(2,4)
%        junta2z=V{2}(3,4)
%        junta3x=V{3}(1,4)
%        junta3z=V{3}(2,4)
%        junta3z=V{3}(3,4)
%        X=[junta1x, junta2x, junta3x; junta1y, junta2y, junta3y; junta1z, junta2z, junta3z]

    end
end

