for g=1:25
    aa = (4000001*g)-4000000;
    bb = 4000001*g;
    s=bity8(aa:bb);

Nyy=(length(s));
n=Nyy/8;
litery=string(n);
mean=2500;
std=sqrt(5000);
pb=[37/256,56/256,70/256,56/256,37/256];

for i=1:260004 
    a = (8*i)-7;
    b = 8*i;
    liczby = s(a:b);
    skrajne_bajty(i,1:8) = liczby(1:8);
    zliczone(i)= sum(skrajne_bajty(i,1:8));
    if(zliczone(i)<3)
        litery(i)='A';
    elseif(zliczone(i)==3)
        litery(i)='B';
    elseif(zliczone(i)==4)
        litery(i)='C';
    elseif(zliczone(i)==5)
        litery(i)='D';
    else
        litery(i)='E';
    end
end

for i=1:260000
    slownik_5liter(i,1:5)=char(litery(i:(i+4)));
    l1=char(slownik_5liter(i,1));
    l2=char(slownik_5liter(i,2));
    l3=char(slownik_5liter(i,3));
    l4=char(slownik_5liter(i,4));
    l5=char(slownik_5liter(i,5));
    temp1=[l1,l2,l3,l4,l5];
    temp2=string(temp1);
    polaczone5(i)=temp2;
    
    slownik_4liter(i,1:4)=char(litery(i:(i+3)));
    l11=char(slownik_4liter(i,1));
    l22=char(slownik_4liter(i,2));
    l33=char(slownik_4liter(i,3));
    l44=char(slownik_4liter(i,4));
    temp11=[l11,l22,l33,l44];
    temp22=string(temp11);
    polaczone4(i)=temp22;
end

%% Zliczenie wyst¹pieñ

[uni,~,idx] = unique(polaczone4);
[zliczenie4 test1] = hist(idx,unique(idx));
%plot(zliczenie4);
%title('slowa 4-literowe');
liczebnosc4v2=[transpose(uni), transpose(num2cell(zliczenie4))];

%figure
 
[uni2,~,idx2] = unique(polaczone5);
[zliczenie5 test3] = hist(idx2,unique(idx2));
%plot(zliczenie5);
%title('slowa 5-literowe');

liczebnosc5v2=[transpose(uni2), transpose(num2cell(zliczenie5))];

chsq=0;

%% Wartoœæ oczekiwana dla 5
no_wds = 256000;
ltrspwd = 5; 
wdspos = 5^ltrspwd; 
prob = [37/256 56/256 70/256 56/256 37/256]; 
for k=0:wdspos-1
      Ef5 = no_wds;
      wd  = k;
      for l=1:ltrspwd 
        ltr = mod(wd,5)+1;
        Ef5 = Ef5*prob(ltr); 
        wd = floor( wd/5);
      end
     e5(k+1)=Ef5; 
end
%figure
%plot(e5)
%title('Wartosc oczekiwana dla 5-literowych');

%% Wartoœæ oczekiwana dla 4
clear wd;
clear ltr;

ltrspwd = 4; 
wdspos = 5^ltrspwd; 
for k=0:wdspos-1
      Ef4 = no_wds;
      wd  = k;
      for l=1:ltrspwd 
        ltr = mod(wd,5)+1;
        Ef4 = Ef4*prob(ltr); 
        wd = floor( wd/5);
      end
     e4(k+1)=Ef4;
     
end
%figure
%plot(e4)
%title('Wartosc oczekiwana dla 4-literowych');
%% 
%chsq5=((zliczenie5-e5).*(zliczenie5-e5))./e5;
%chsq5=sum(chsq5);
%chsq4=((zliczenie4-e4).*(zliczenie4-e4))./e4;
%chsq4=sum(chsq4);

chi2stat5 = sum((zliczenie5-e5).^2 ./ e5)
chi2stat55(g)=chi2stat5;
chi2stat4 = sum((zliczenie4-e4).^2 ./ e4)
chi2stat54(g)=chi2stat4;
q5q4=chi2stat5-chi2stat4;
q55q44(g)=q5q4;
z =(q5q4-mean)/std

%c.d.f of Standard Normal

tmp=z/sqrt(2);
tmp=1+erf(tmp);
Phi=tmp/2;

%1-phi
mphi(g)=1-Phi;

zz(g)=z;
%koniec petli
end
for h=1:24
    chi2stat54(h)=chi2stat54(h+1)
end

for h=1:24
    mphi(h)=mphi(h+1)
end

for h=1:24
    chi2stat55(h)=chi2stat55(h+1)
end

for h=1:24
    q55q44(h)=q55q44(h+1)
end

bar(chi2stat54);
figure
bar(chi2stat55);
figure
bar(q55q44);
figure
plot(e4)
title('Wartosc oczekiwana dla slow 4-literowych');
figure
plot(e5)
title('Wartosc oczekiwana dla slow 5-literowych');
figure
plot(zliczenie5);
title('Wykres wystepowania slow 5-literowych');
figure
plot(zliczenie4);
title('Wykres wystepowania slow 4-literowe');
cdf=makedist('uniform')
[h,p_values] = kstest(mphi,cdf);


