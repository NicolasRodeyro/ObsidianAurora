# Tutorial de integración — Aurora Care Front ↔ Aurora Core API

## 1. Datos de conexión (desarrollo local)

| Dato | Valor |
|---|---|
| Base URL API | `http://localhost:8000/api/v1/` |
| Auth0 Domain | `dev-riyweuxin7mzr3vb.us.auth0.com` |
| Auth0 Client ID | `Axe2GZyDkSBWT87ffmmor22k59NuPe5z` |
| Audience (API Identifier) | `https://api.aurora-memory.com` |
| Scopes | `openid profile email` |
| Swagger UI | `http://localhost:8000/api/v1/docs/` |

⚠️ **Regla de oro**: el token se pide SIEMPRE con `audience`. Si no, Auth0 emite un token *opaco* (no JWT) y el backend responde `401 Token inválido`. Es el error #1 de integración (ver `docs/auth0-setup.md` en AuroraCoreBack).

## 2. Autenticación (OAuth2 Authorization Code + PKCE)

El backend **no maneja sesión ni login**: solo valida el JWT en cada request contra el JWKS de Auth0 (`apps/common/auth0.py`).

- Header: `Authorization: Bearer <token>`
- Validación: firma RS256 + issuer (`https://{domain}/`) + audience
- El access token NO incluye `email`/`name` por defecto; el backend los lee de claims namespaced (`https://aurora-memory.com/email`).

## 3. Setup en la app (React con `@auth0/auth0-react`)

```bash
npm install @auth0/auth0-react
```

```jsx
// src/auth/AuthProvider.jsx
import { Auth0Provider } from '@auth0/auth0-react';

export const AuthProvider = ({ children }) => (
  <Auth0Provider
    domain="dev-riyweuxin7mzr3vb.us.auth0.com"
    clientId="Axe2GZyDkSBWT87ffmmor22k59NuPe5z"
    authorizationParams={{
      redirect_uri: window.location.origin,          // ej: http://localhost:3000
      audience: 'https://api.aurora-memory.com',     // OBLIGATORIO (paso 2)
      scope: 'openid profile email',
    }}
    cacheLocation="localstorage"
    useRefreshTokens
  >
    {children}
  </Auth0Provider>
);
```

## 4. Llamar a la API

```jsx
// src/api/client.js
import { useAuth0 } from '@auth0/auth0-react';

const BASE = 'http://localhost:8000/api/v1';

export function useApi() {
  const { getAccessTokenSilently } = useAuth0();

  const request = async (path, options = {}) => {
    const token = await getAccessTokenSilently(); // incluye audience automáticamente
    const res = await fetch(`${BASE}${path}`, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`,
        ...options.headers,
      },
    });
    if (!res.ok) throw await res.json();
    return res.json();
  };

  return { request };
}
```

## 5. Ejemplo de uso

```jsx
const { request } = useApi();
const ctx = await request('/session/context/');
// GET /api/v1/session/context/
```

## 6. Errores posibles y qué significan

| Código | Cuerpo / mensaje | Qué hacer |
|---|---|---|
| `200` | payload normal | Token válido y caregiver vinculado |
| `401` | `Token inválido` / `Token expirado` | Token opaco (falta `audience`), expirado o firma mala → re-login |
| `403` | `Usuario sin perfil de cuidador asociado` | Token válido pero el `sub` no tiene fila `Caregiver` en backend → avisar a backend para vincular |
| `503` | `Proveedor de identidad no disponible` | No se alcanza el JWKS de Auth0 → retry con backoff |

Formato de error estándar de la API:

```json
{ "error": { "code": "UNAUTHORIZED", "message": "Token inválido", "details": {} } }
```

Paginación: `?page=1&page_size=20` → `{ "count", "next", "previous", "results" }`. Fechas ISO 8601 UTC.

## 7. Checklist antes de reportar un bug de auth

1. ¿Pido el token con `audience`?
2. ¿Redirijo a la URL que Auth0 tiene como *Allowed Callback URL*? (en dev: `http://localhost:3000`)
3. ¿El access token es un **JWT** (3 segmentos, se puede decodificar en jwt.io)?
4. ¿El `sub` del token (ej `google-oauth2|1007...`) coincide con el caregiver que creó el backend?
5. Probar primero en Swagger (`/api/v1/docs/` → Authorize): si funciona ahí y no en la app, el problema es del cliente.

## 8. Modo dev sin Auth0 (opcional)

El backend tiene bypass en dev: con `AUTH_DEV_MODE=True` acepta el token estático `aurora-local-token` (`config/settings/base.py`). Útil para mockear auth mientras tanto, pero **no vale para validar flujos reales** (login social, refresh, claims).
