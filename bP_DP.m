pt = input('What is Total Pressure in kpa?');
ptinmmhg = (pt / 101.3)*760;
nofcomp = input('How many components your system have?');
Ants = zeros(nofcomp,3);
x = zeros(1,nofcomp);

for i=1:nofcomp
   disp(['Component ',num2str(i)]);
   Ant_A = input('Please Enter the Value of Ant A = ');
   Ant_B = input('Please Enter the Value of Ant B = ');
   Ant_C = input('Please Enter the Value of Ant C = ');
   fraction = input('Mole Fraction = ');
   Ants(i,1) = Ant_A;
   Ants(i,2) = Ant_B;
   Ants(i,3) = Ant_C;
   x(1,i) = fraction;
end

if sum(x)~= 1
    disp('Sum of fractions is not 1!!');
else
    disp('------Rauolt-Dalton------');
     Tb = zeros(nofcomp,1);
    for i = 1:nofcomp
        T = (Ants(i,2)/(Ants(i,1)-log(ptinmmhg))) - Ants(i,3);
        Tb(i,1) = T;
    end
    Tbm = 0;
    for i=1:nofcomp
        Tbm = Tbm + x(1,i)*Tb(i,1);
    end
    disp(['Tbm = ',num2str(Tbm),' K']);
    pstars = zeros(nofcomp,1);
    for i=1:nofcomp
        I = Ants(i,1) - Ants(i,2)/(Tbm + Ants(i,3));
        pstar = exp(I);
        pstars(i,1) = pstar;
    end
    
    
    sumx_p=0;
    for i=1:nofcomp
        sumx_p = sumx_p + x(1,i)*pstars(i,1);
    end
    if sumx_p - ptinmmhg <= 0.01*ptinmmhg 
       disp(['Bubble point of mixture is = ',num2str(Tbm)]);
        
    elseif sumx_p - ptinmmhg > 0.001*ptinmmhg
        %to decrease Tbm 
            n = 1;
            while sumx_p - ptinmmhg > 0.001*ptinmmhg 
                Tbm = Tbm - 0.1*n;
                disp([num2str(n+1),'Tbm = ',num2str(Tbm),' K']);
                pstars = zeros(nofcomp,1);
                  for i=1:nofcomp
                      I = Ants(i,1) - Ants(i,2)/(Tbm + Ants(i,3));
                      pstar = exp(I);
                      pstars(i,1) = pstar;
                  end
                  sumx_p=0;
                  for i=1:nofcomp
                    sumx_p = sumx_p + x(1,i)*pstars(i,1);
                  end
                n = n + 1;
            end
            disp(['Tbm = ',num2str(Tbm),' K']);
            disp(sumx_p);
        
    else
         %to increase Tbm 
     end
    
   
        
end
    
    


