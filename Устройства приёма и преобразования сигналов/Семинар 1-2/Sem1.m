%%Создание структуры для решения задач
inPutData = struct('SdB', 0, 'SdBm', 0, 'Uin_min', 0, 'Pa_min', 0, ... 
     'Ea_min', 0, 'Uin', 0,  'Ea', 0, 'Ra', 0, 'Rin_rec', 0);

tasks =[inPutData, inPutData, inPutData];

%%Задача №1
%Чувствительность приёмника S = -111 дБм. приёмник согласован с антенной
%Ra = Rвх.пр. = 50 Ом
%Определить: S[дБ], Pa.мин[Вт], Uвх.мин[В], Ea.мин[В].

fprintf("Решение первой задачи: \n")

tasks(1).SdBm = -111;
tasks(1).Ra = 50;
tasks(1).Rin_rec = 50;

tasks(1).SdB = tasks(1).SdBm - 30;                           %S[дБ]
tasks(1).Pa_min = 10^(tasks(1).SdB/10);                      %Pa_min[Вт]
tasks(1).Uin_min = sqrt(tasks(1).Pa_min * tasks(1).Rin_rec); %Uin_min[В]
tasks(1).Ea_min = 2*tasks(1).Uin_min;                        %Ea_min[В]

tasks(1)
fprintf("\n")

%%Задача №2
%Чувствительность приёмника Pa.мин = 4*10^-12 Вт.
%Отношение с/ш на выходе приёмника y = 3. Приёмник согласован с антенной
%Ra = Rвх.пр. = 100 Ом
%Определить реальные значения: S[дБ], S[дБм], Uвх[В], Ea[В].

fprintf("Решение второй задачи: \n")

tasks(2).Pa_min = 4*10^-12;
y = 3;
tasks(2).Ra = 100;
tasks(2).Rin_rec = 100;

Preal = tasks(2).Pa_min * y;                                 %Pa_real[Вт]
tasks(2).SdB = 10*log10(Preal);                              %S[дБ]
tasks(2).SdBm = tasks(2).SdB + 30;                           %S[дБм]
tasks(2).Uin = sqrt(Preal * tasks(2).Rin_rec);               %Uin_real[В]
tasks(2).Ea = 2 * tasks(2).Uin;                              %Ea_real[В]

tasks(2)
fprintf("\n")

%%Задача №3
%ЭДС антенны Ea.мин = 2 мкВ, Ra = Rвх.пр. = 50 Ом.
%Определить: Pa.мин[Вт], S[дБ], S[дБм], Uвх.мин[В].

fprintf("Решение третьей задачи: \n")

tasks(3).Ea_min = 2*10^-6;
tasks(3).Ra = 50;
tasks(3).Rin_rec = 50;

tasks(3).Pa_min = (tasks(3).Ea_min)^2/(4*tasks(3).Rin_rec);  %Pa_min[Вт]
tasks(3).SdB = 10*log10(tasks(3).Pa_min);                    %S[дБ]
tasks(3).SdBm = tasks(3).SdB + 30;                           %S[дБм]
tasks(3).Uin_min = tasks(3).Ea_min/2;                        %Uin_min[В]

tasks(3)
fprintf("\n")

%%Задача №4
%Определить, на сколько децибел одиночный колебательный контур
%ослабляет помеху, отстоящую на полосу контура от резонансной частоты (Occ)

fprintf("Решение четвёртой задачи: \n")

a = 2;
answer = ACHX(2)
answer_dB = 20*log10(answer)
ACHX(0:0.1:8);

fprintf("\n")

%%Задача №5
%Определить, на сколько децибел преселектор супергетеродинного приёмника с  
%несколькими развязанными между собой колебательными контурами ослабляет:
%1)сигнал на границе полосы пропускания прёмника (Oгр)
%2)помеху, отстоящую на полосу приёмника от резонансной частоты (Occ)
%3зеркальную помеху(Oзер)

fprintf("Решение пятой задачи: \n")

task5 = struct('Qekv', 50, 'fc', 150*10^6, 'PPrec', 100*10^3, ...
    'fp', 5*10^6);

PP_presel = task5.fc/task5.Qekv;

sigma_vector_2 = [sigma(task5.PPrec/2,2, PP_presel), ...
    sigma(task5.PPrec,2, PP_presel), sigma(2 * task5.fp,2, PP_presel)];

sigma_vector_3 = [sigma(task5.PPrec/2,3, PP_presel), ...
    sigma(task5.PPrec,3, PP_presel), sigma(2 * task5.fp,3, PP_presel)];

sigma_vector_2_dB = 20*log10(sigma_vector_2)

sigma_vector_3_dB = 20*log10(sigma_vector_3)

fprintf("\n")

%%Функции необходимые для решения

function O = ACHX(a)
    f = 1./sqrt(1 + (a).^2);
    O = 1./f;
    
    if(length(f) > 1)
        subplot(2,1,1);
        plot(a,f)
        grid on;
        title('График АЧХ');
        ylabel('АЧХ');
        xlabel('Значение расстройки')
    end
    
    if(length(O) > 1)
        subplot(2,1,2);
        plot(a,O)
        grid on;
        title('График величины обратной к АЧХ')
        ylabel('Значение обратное к АЧХ');
        xlabel('Значение расстройки')
    end
end

function O = sigma(delf, n, PP_presel)
    O = (sqrt(1+(2*delf/PP_presel)^2))^n;
end






