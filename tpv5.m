% Charger l'image "morp.tif"
img = imread("Ressources/morp.tif","tif");

% Afficher l'image originale
figure;
imshow(img);
title('Image originale');

% Déterminer le type de l'image
disp('Type de l''image :');
disp(class(img)); % Affiche le type (uint8, double, etc.)

% Afficher l'histogramme de l'image
figure;
imhist(img);
title('Histogramme de l''image');

% Binariser l'image pour garder les pixels les plus clairs
threshold = 200; % Seuil à ajuster selon l'image
BW = img > threshold;

% Afficher l'image binaire
figure;
imshow(BW);
title('Image binaire (BW)');

% Appliquer les opérateurs de morphologie mathématique

% 1. Érosion
se1 = strel('square', 2); % Élément structurant carré de taille 2
BW_erodee = imerode(BW, se1);

% 2. Dilatation
BW_dilatee = imdilate(BW, se1);

% 3. Ouverture
BW_ouver = imopen(BW, se1);

% 4. Fermeture sur l'image ouverte avec un élément structurant de taille 10
se2 = strel('square', 10); % Élément structurant carré de taille 10
BW_ferm = imclose(BW_ouver, se2);

% Afficher les résultats intermédiaires
figure;
subplot(2, 2, 1); imshow(BW_erodee); title('Image érodée (BW_erodee)');
subplot(2, 2, 2); imshow(BW_dilatee); title('Image dilatée (BW_dilatee)');
subplot(2, 2, 3); imshow(BW_ouver); title('Image ouverte (BW_ouver)');
subplot(2, 2, 4); imshow(BW_ferm); title('Image fermée (BW_ferm)');

% Multiplier l'image originale avec l'image binaire finale
result = uint8(BW_ferm) .* img;

% Afficher l'image finale après multiplication
figure;
imshow(result);
title('Image originale multipliée par BW_ferm');
