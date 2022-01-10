DB_USER_FILE=/run/secrets/postgres_user
DB_PASS_FILE=/run/secrets/postgres_password

DB_USER="$(cat "$DB_USER_FILE")"
DB_PASS="$(cat "$DB_PASS_FILE")"

export DB_URL="postgresql://${DB_USER}:${DB_PASS}@postgres:5432/artisanwriting?schema=public"
npm run prod
