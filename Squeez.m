
counter=1;
for g=1:4
    a = (2500001*g)-2500000;
    b = 2500001*g;
    rr = valuesfull(a:b);
    std=sqrt(84);
    Ef=[21.03,57.79,175.54,467.32,1107.83, 2367.84,4609.44,8241.16,13627.81,20968.49,30176.12,40801.97,52042.03,62838.28,72056.37,78694.51,82067.55,81919.35,78440.08,72194.12,63986.79,54709.31,45198.52,36136.61,28000.28,21055.67,15386.52,10940.20,7577.96,5119.56,3377.26,2177.87,1374.39,849.70,515.18,306.66, 179.39, 103.24, 58.51, 32.69, 18.03,  9.82, 11.21];

     
    no_trials=100000;
    ratio=no_trials/1000000;
    std=sqrt(84);

  for i=1:43
    f(i)=0;
    Ef(i)=Ef(i)*ratio;
  end

for i=1:no_trials
    k=2147483647;
    j=0;
    while((k~=1)&&(j<48))
          k = ceil(k*valuesfull(counter));
          j=j+1;
          counter=counter+1;

    end
      if(j<6)
          j=6;
      elseif(j>48)
          j=48;
      else
          j=j;
      end
      indeks=j-5;
      temp=f(indeks);
      f(indeks)=temp+1;

end
srednia=mean(f)
srednia2=mean(Ef)

figure
plot(f)
hold
plot(Ef)
title('Wykres otrzymanych wartoœci iteracji oraz wartoœci oczekiwanych')

chsq=0;

for i=1:43 
    tmp=(f(i)-Ef(i))/sqrt(Ef(i));
    chsq=chsq+(tmp*tmp);
end

z=(chsq-42)/std
pvalue=1-chi2cdf(chsq,42);
arr(g)=pvalue;
end
cdf=makedist('uniform');
[h,q] = kstest(arr,cdf);
