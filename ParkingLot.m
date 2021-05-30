wspolrzedne=(((liczby/(max(liczby)))*100));

i=1;
pozycja=1;
n=3
for g=1:100

clear xtry;
clear ytry;
clear parkedx;
clear parkedy;
clear i;
clear n;
clear k;


        n=3;
        i=1;
        
        pierwszy = pozycja;
        drugi = (pozycja+24000)-1;
        if(drugi<100000)
        first_24k = wspolrzedne(pierwszy:drugi);
        end
        
        if(drugi>100000)
            drugi=mod(drugi,100000)
            first=wspolrzedne(pierwszy:100000);
            second=wspolrzedne(1:drugi);
            first_24k = [first second];
        end
        
        
        
        zakresy(g,1)=pierwszy;
        zakresy(g,2)=drugi;

parkedx(1)= first_24k(1);
parkedy(1)= first_24k(2);
k=1;
    while n <= 24000
    xtry=first_24k(n);
    ytry=first_24k(n+1);
    crashed=0;

        for i=1:length(parkedy)
            if ((abs(parkedx(i) - xtry) <= 1.0) && (abs(parkedy(i) - ytry) <= 1.0))
                crashed=1;
                break;
            end
        end
       if(crashed == 0)
         parkedx(k) = xtry;
         parkedy(k) = ytry;
         crashed = 0;
         k=k+1;
       end
       n=n+2;
    end
    
    tablica_wynikow(g)=k;
    pozycja=drugi+g;

end
    
do_hista=(tablica_wynikow - 3523)/21.9;
histogram(do_hista,10, 'Normalization','probability');
ax = gca;
ax.YAxis.Exponent = 0;
title('Empiryczny rozk³ad prób bezkolizyjnych')
ylabel('czêstoœæ wystêpowania (p_i)')
xlabel('wartoœæ (x_i)')

figure

for i=1:100
    [h,temp] = kstest(do_hista(i));
    arr(i)=temp;
end

histogram(arr,10,'Normalization','probability' );
ax = gca;
ax.YAxis.Exponent = 0;
title('Empiryczny rozk³ad wartoœci p')
ylabel('czêstoœæ wystêpowania (p_i)')
xlabel('wartoœæ (x_i)')

[h,p] = kstest(do_hista);