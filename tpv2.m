img = imread("Documents/ISEN/CIPA5/ImageTraitement/TP/Ressources/cameraman.jpg",'jpg');
img_nv_g = rgb2gray(img);

% Appliquer le filtre de Canny
edges = edge(img_nv_g, 'Canny');

% Appliquer le filtre de Canny avec des seuils personnalisés
lowThreshold = 0.05;  % Seuil faible
highThreshold = 0.16; % Seuil fort
edges_canny = edge(img_nv_g, 'Canny', [lowThreshold, highThreshold]);

% Appliquer les contours en rouge
image_colored = img; % Copier l'image originale
image_colored(:,:,1) = image_colored(:,:,1) + uint8(edges_canny) * 255; % Rouge (canal R)

% Afficher les résultats
figure;
subplot(1, 4, 1);
imshow(img);
title('Image originale');

subplot(1, 4, 2);
imshow(edges);
title('Contours détectés (Canny)');

subplot(1, 4, 3);
imshow(edges_canny);
title('Contours après seuillage');

subplot(1, 4, 4);
imshow(image_colored);
title('Image avec contours rouges');

%==================================================

% Appliquer le filtre de Sobel
edges = edge(img_nv_g, 'sobel');

% Appliquer les contours en rouge
image_colored = img; % Copier l'image originale
image_colored(:,:,1) = image_colored(:,:,1) + uint8(edges) * 255; % Rouge (canal R)
% Afficher les résultats
figure;
subplot(1, 4, 1);
imshow(img);
title('Image originale');

subplot(1, 4, 2);
imshow(edges);
title('Contours détectés (Sobel)');

subplot(1, 4, 4);
imshow(image_colored);
title('Image avec contours rouges');

%==================================================

% Appliquer le filtre de Prewitt
edges = edge(img_nv_g, 'Prewitt');

% Appliquer les contours en rouge
image_colored = img; % Copier l'image originale
image_colored(:,:,1) = image_colored(:,:,1) + uint8(edges) * 255; % Rouge (canal R)

% Afficher les résultats
figure;
subplot(1, 4, 1);
imshow(img);
title('Image originale');

subplot(1, 4, 2);
imshow(edges);
title('Contours détectés (Prewitt)');

subplot(1, 4, 4);
imshow(image_colored);
title('Image avec contours rouges');