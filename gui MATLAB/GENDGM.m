function [T,MatrizParcial,MatrizInterm] = GENDGM(sigma,a,alpha,d,theta,q)

%   Variables Analizadas
    [n1,n2]=size(sigma);          %Sigma es la varialbe que determina si es una union de rotacion(0) o traslacion(1)
    [n3,n4]=size(a);              %Distancia entre zi-1 y zi sobre xi
    [n5,n6]=size(alpha);          %Angulo entre zi-1 y zi alrededor de xi
    [n7,n8]=size(d);              %distancia entre origen Ri-1 y punto donde xi y zi intersectan
    [n9,n10]=size(theta);         %Angulo entre xi-1 y xi alrededor de zi-1
    [n11,n12]=size(q);            %Valor sobre el cual se quiere calcular

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
                MatrizInterm=T;
                X=[T(1,4)];
                Y=[T(2,4)];
                Z=[T(3,4)];
            else
                j;
                MatrizParcial=[MatrizParcial rotZaxis(theta(j,1))*transZaxis(d(j,1))*rotXaxis(alpha(j,1))*transXaxis(a(j,1))];
                T=T*(rotZaxis(theta(j,1))*transZaxis(d(j,1))*rotXaxis(alpha(j,1))*transXaxis(a(j,1)));
                MatrizInterm=[MatrizInterm T];
                X=[X T(1,4)];
                Y=[Y T(2,4)];
                Z=[Z T(3,4)];
            end
            j=j+1;
        end
    end
end

