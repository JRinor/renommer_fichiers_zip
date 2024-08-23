@echo off
setlocal enabledelayedexpansion

:: Définir le répertoire contenant les fichiers
set "repertoire=%cd%"

:: Initialiser les compteurs
set /a compteur=1
set /a fichiers_trouves=0
set /a changements=0

:: Liste des fichiers .zip dans le répertoire
for %%f in ("%repertoire%\*.zip") do (
    :: Compter le fichier trouvé
    set /a fichiers_trouves+=1
    
    :: Obtenir l'extension du fichier (ce sera .zip pour tous les fichiers concernés)
    set "extension=%%~xf"
    
    :: Construire le nouveau nom de fichier
    set "nouveau_nom=!compteur!!extension!"

    :: Si le fichier avec ce nom existe déjà, trouver un nouveau numéro
    :vérifier_nom
    if exist "%repertoire%\!nouveau_nom!" (
        set /a compteur+=1
        set "nouveau_nom=!compteur!!extension!"
        goto :vérifier_nom
    )

    :: Renommer le fichier
    echo Renommage de "%%f" en "!nouveau_nom!"
    ren "%%f" "!nouveau_nom!"
    set /a changements+=1

    :: Incrémenter le compteur
    set /a compteur+=1
)

:: Afficher le récapitulatif
echo.
echo Récapitulatif de l'opération :
echo Nombre de fichiers trouvés : %fichiers_trouves%
echo Nombre de fichiers renommés : %changements%

:: Maintenir le terminal ouvert
pause
