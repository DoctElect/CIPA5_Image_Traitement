% Taille de la grille
rows = 200;   % Nombre de lignes
cols = 200;   % Nombre de colonnes

% Grille initiale aléatoire (0 = mort, 1 = vivant)
grid = randi([0, 1], rows, cols);

% Nombre de générations
numGenerations = 1000;

% Affichage initial
figure;

% Filtre pour compter les voisins (masque de convolution)
filter = [1, 1, 1; 1, 0, 1; 1, 1, 1];
fps = 30;
for gen = 1:numGenerations
    % Calcul des voisins avec une convolution
    neighbors = conv2(grid, filter, 'same');
    
    % Appliquer les règles du jeu
    grid = (grid == 1 & (neighbors == 2 | neighbors == 3)) | (grid == 0 & neighbors == 3);
    
    % Affichage
    imagesc(grid);
    colormap(gray);
    axis equal tight;
    title(['Génération : ', num2str(gen)]);
    pause(1/fps);
end