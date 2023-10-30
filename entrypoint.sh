#!/bin/bash

# Naviguer dans le répertoire du projet
cd /app

# Créer et migrer la base de données
mix ecto.setup

# Attente de la disponibilité de la base de données
while ! pg_isready -h $PGHOST -p $PGPORT -q -U $PGUSER
do
  echo "$(date) - en attente de la base de données..."
  sleep 1
done

echo "La base de données est prête !"

# Créer la base de données (ne fait rien si elle existe déjà)
mix ecto.create

# Exécuter les migrations de la base de données
mix ecto.migrate

# Démarrer le serveur Phoenix
mix phx.server
#!/bin/bash

# Naviguer dans le répertoire du projet
cd /app

# Installer les dépendances
mix deps.get
