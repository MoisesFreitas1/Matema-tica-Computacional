%Calcula o epsilon da m�quina
function es = epsilon()
    es = 1;
    while es + 1 > 1
        es = es/2;
    end
    es = 2*es;
end