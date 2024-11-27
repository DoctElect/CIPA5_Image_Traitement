% Charger l'image "image.png"
img = imread("image.png","png");

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

% Convertir en niveaux de gris si l'image est en couleur
if size(img, 3) == 3
    image_gris = rgb2gray(img);
else
    image_gris = img;
end

% Binariser l'image avec un seuil automatique (méthode d'Otsu)
seuil = graythresh(image_gris); % Calcule le seuil optimal
image_binaire = imbinarize(image_gris, seuil);

% Afficher l'image binaire
figure;
imshow(image_binaire);
title('Image binaire');


% Appliquer les opérateurs de morphologie mathématique

% 1. Érosion
se1 = strel('square', 2); % Élément structurant
BW_erodee = imerode(image_binaire, se1);

% 2. Dilatation
BW_dilatee = imdilate(image_binaire, se1);

% 3. Ouverture
BW_ouver = imopen(image_binaire, se1);

% 4. Fermeture sur l'image ouverte avec un élément structurant
se2 = strel('square', 10); % Élément structurant
BW_ferm = imclose(BW_ouver, se2);

% Afficher les résultats intermédiaires
figure;
subplot(2, 2, 1); imshow(BW_erodee); title('Image érodée (BW_erodee)');

subplot(2, 2, 2); imshow(BW_dilatee); title('Image dilatée (BW_dilatee)');
subplot(2, 2, 3); imshow(BW_ouver); title('Image ouverte (BW_ouver)');
subplot(2, 2, 4); imshow(BW_ferm); title('Image fermée (BW_ferm)');

% Étiquetage des objets
[img_label, num_objects] = bwlabel(BW_ferm);

figure;
imshow(img_label);

% Afficher le nombre d'objets détectés
fprintf('Nombre d''objets détectés : %d\n', num_objects);

img_fill = imfill(img_label,"holes");

% Calculer les propriétés géométriques
props = regionprops(img_fill, 'Area', 'Perimeter', 'BoundingBox');

% Créer une nouvelle image binaire pour conserver uniquement les cercles/disques
nouvelle_image = false(size(image_binaire));
bounding_boxes = []; % Liste des bounding boxes à afficher

for k = 1:num_objects
    % Récupérer l'aire et le périmètre de l'objet
    A = props(k).Area;
    P = props(k).Perimeter;
    
    % Vérifier la condition : 0.8 <= (7.4 * pi * A) / (P^2) <= 1.2
    if P > 0 % Éviter les divisions par zéro
        critere = (4 * pi * A) / (P^2);
        if critere >= 0.8 && critere <= 1.2
            % Conserver cet objet
            nouvelle_image = nouvelle_image | (img_fill == k);
            bounding_boxes = [bounding_boxes; props(k).BoundingBox];
        end
    end
end

% Afficher l'image binaire
figure;
imshow(nouvelle_image);
title('Image contenant uniquement les cercles/disques');

% Convertir l'image originale en RGB pour superposition
if size(img, 3) == 1
    image_originale_rgb = cat(3, img, img, img);
else
    image_originale_rgb = img;
end

% Dessiner les rectangles englobants en vert sur l'image originale
for i = 1:size(bounding_boxes, 1)
    rectangle_position = bounding_boxes(i, :); % Position [x, y, largeur, hauteur]
    image_originale_rgb = insertShape(image_originale_rgb, 'Rectangle', rectangle_position, ...
                                      'Color', 'green', 'LineWidth', 3);
end

% Afficher l'image avec les rectangles englobants
figure;
imshow(image_originale_rgb);
title('Image originale avec rectangles englobants (cercles/disques)');