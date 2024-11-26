image = imread("Ressources/chiffres.png","png");

img_gray = rgb2gray(image);

% Afficher l'image originale
figure;
imshow(img_gray);
title('Image originale en niveaux de gris');

% Seuillage binaire (binarisation)
threshold = 100; % Ajustez ce seuil en fonction de l'image
img_binary = img_gray > threshold;

% Afficher l'image binaire
figure;
imshow(img_binary);
title('Image binaire après seuillage');

% Étiquetage des objets
[img_label, num_objects] = bwlabel(img_binary);

figure;
imshow(img_label);

% Afficher le nombre d'objets détectés
fprintf('Nombre d''objets détectés : %d\n', num_objects);

% Coloration des objets étiquetés (une couleur par objet)
img_color = label2rgb(img_label, 'jet', 'k', 'shuffle');

% Afficher les objets colorés
figure;
imshow(img_color);
title('Image des objets colorés (une couleur par objet)');

% Afficher tous les résultats
figure;
subplot(2, 2, 1);
imshow(img_gray);
title('Image originale');

subplot(2, 2, 2);
imshow(img_binary);
title('Image binaire');

subplot(2, 2, 3);
imshow(label2rgb(img_label, 'parula', 'k', 'shuffle'));
title('Étiquetage des objets');

subplot(2, 2, 4);
imshow(img_color);
title('Objets colorés');