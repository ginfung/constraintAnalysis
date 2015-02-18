clear all
Problem = @SXFM_e1;
NP = 100;
CR = 0.3;
F = 0.3;
gen_max = 50;
D = 10;
ObjectiveDimension = 2;

parent = randi([0 1],NP,D); %initialize in the binary space
f = zeros(NP,ObjectiveDimension);

%get the objective for initial parent
for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end

trial = zeros(1,D);
trial_objective = zeros(1,ObjectiveDimension);

count = 1;
while (count <= gen_max)
    for i = 1:NP
        %get distinct a,b,c
        rev = randperm(NP);
        a = rev(1);
        b = rev(2);
        c = rev(3);
        
        for k = 1:D
            if (rand()<CR || k == D)
                if rand() > F
                    trial(k) = parent(a,k);
                else
                    if rand()>0.5
                        trial(k) = parent(b,k);
                    else
                        trial(k) = parent(c,k);
                    end
                end
            else
                trial(k) = parent(i,k);
            end
        end
        
        trial_objective = Problem(trial,D);
        
        if testDominate(trial_objective,f(i,:),ObjectiveDimension)
            parent(i,:) = trial;
            f(i,:) = trial_objective;
         end         
    end
    count  = count + 1;
end

for i = 1:NP
    f(i,:) = Problem(parent(i,:),D);
end


