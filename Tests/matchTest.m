% BeerPong Simulator match test, 10 shots per player

nn1 = createNeuralNetwork();
nn2 = createNeuralNetwork();
[s1,s2] = beerpongMatch(nn1,nn2,1000,false);

disp(s1)
disp(s2)