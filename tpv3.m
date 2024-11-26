image = imread("Ressources/fleurs.jpg","jpg");

% Vérifier si l'image est bien en couleur (RGB)
if size(image, 3) ~= 3
    error('L''image n''est pas en couleur.');
end

% Extraire les composantes R, G et B
R = image(:, :, 1); % Composante rouge
G = image(:, :, 2); % Composante verte
B = image(:, :, 3); % Composante bleue

% Afficher les composantes
figure;
subplot(1, 3, 1); imshow(R); title('Composante Rouge (R)');
subplot(1, 3, 2); imshow(G); title('Composante Verte (G)');
subplot(1, 3, 3); imshow(B); title('Composante Bleue (B)');

% Afficher les histogrammes des 3 composantes
figure;
subplot(1, 3, 1); imhist(R); title('Histogramme Rouge (R)');
subplot(1, 3, 2); imhist(G); title('Histogramme Vert (G)');
subplot(1, 3, 3); imhist(B); title('Histogramme Bleu (B)');

% Méthode de seuillage binaire pour détecter la couleur jaune
% On considère que le jaune a des valeurs élevées en R et G, mais faibles en B
threshold_R = 150; % Ajustez selon l'image
threshold_G = 150; % Ajustez selon l'image
threshold_B = 100; % Ajustez selon l'image

BW_R = R > threshold_R; % Seuillage pour R
BW_G = G > threshold_G; % Seuillage pour G
BW_B = B < threshold_B; % Inversé pour B (faible intensité)

% Combiner les trois composantes pour détecter le jaune
BW_Yellow = BW_R & BW_G & BW_B;

% Afficher les images binaires
figure;
subplot(1, 4, 1); imshow(BW_R); title('Image Binaire Rouge (BW_R)');
subplot(1, 4, 2); imshow(BW_G); title('Image Binaire Verte (BW_G)');
subplot(1, 4, 3); imshow(BW_B); title('Image Binaire Bleue (BW_B)');
subplot(1, 4, 4); imshow(BW_Yellow); title('Détection de Jaune (BW_Yellow)');

% Combiner les images binaires pour créer un masque final
Mask = BW_R & BW_G & BW_B;

% Afficher le masque (image binaire)
figure;
imshow(Mask);
title('Masque binaire des pixels jaunes');

% Appliquer le masque à l'image originale
image_yellow = uint8(Mask) .* image; % Multiplie chaque canal par le masque

% Afficher l'image originale et le résultat final
figure;
subplot(1, 2, 1);
imshow(image);
title('Image originale');

subplot(1, 2, 2);
imshow(image_yellow);
title('Image avec les pixels jaunes isolés');