function[T, MatrizParcial,MatrizInterm] = GENDGM(sigma, a, alpha, d, theta, q)
  % Sigma Es la varialbe que determina si es una union de rotacion(0) o traslacion(1)
  %   A   Distancia entre zi-1 y zi sobre xi
  % alpha Angulo entre zi-1 y zi alrededor de xi
  %   d   Distancia entre origen Ri-1 y punto donde xi y zi intersectan
  % theta Angulo entre xi-1 y xi alrededor de zi-1
  %   q   Valor sobre el cual se quiere calcular

% [T, MatrizInterm] = GENDGM([0 0 0], [0 L2 L3], [pi/2 -pi -pi/2], [L1 0 0], [4.0376 -2.0410 2.0862], [q(1) q(2) q(3)])

    i = length(sigma);
    j = 0;
    ans = 1;
    T = 1;
    for j = 1:i

        if sigma(j) == 0
            A{j} = rotZaxis(q(j))*transZaxis(d(j))*rotXaxis(alpha(j))*transXaxis(a(j));
    
        elseif sigma(j) == 1
            A{j}=rotZaxis(theta(j))*transZaxis(q(j))*rotXaxis(alpha(j))*transXaxis(a(j));

        end
    %Matriz parcial es 0T1-1T2-2T3
    MatrizParcial(:,:,j) = A{j};
    MatrizParcial = double(MatrizParcial);
    ans * A{j};
    T = T * A{j};
    %Matriz intermedia es 0T1-0T2-0T3 
    MatrizInterm(:,:,j) = T;
    
    end
    
    T = ans;

end