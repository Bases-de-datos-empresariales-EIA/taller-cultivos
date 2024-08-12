Claro, aquí tienes un `README.md` que explica las tablas y sus relaciones en el esquema `cultivo`.

```markdown
# Esquema `cultivo`

Este documento describe las tablas y sus relaciones dentro del esquema `cultivo` en la base de datos. A continuación, se proporciona una descripción de cada tabla, así como las relaciones entre ellas.

## Tablas

### `Invoice`

- **Descripción**: Almacena información sobre las facturas.
- **Campos**:
  - `id`: Identificador único de la factura (clave primaria).
  - `date`: Fecha de la factura.
  - `invoiceNumber`: Número de la factura.
  - `kg`: Cantidad en kilogramos.
  - `price`: Precio.
  - `grossTotal`: Total bruto.
  - `tax`: Impuesto.
  - `deduction`: Deducción.
  - `netTotal`: Total neto.
  - `createdAt`: Fecha y hora de creación.
  - `isNulled`: Indica si la factura ha sido anulada.
  - `updatedAt`: Fecha y hora de la última actualización.
  - `salesDeduction`: Deducción por ventas.
  - `finalValue`: Valor final.

### `Lot`

- **Descripción**: Representa un lote en el sistema.
- **Campos**:
  - `id`: Identificador único del lote (clave primaria).
  - `name`: Nombre del lote.
  - `createdAt`: Fecha y hora de creación.
  - `updatedAt`: Fecha y hora de la última actualización.
- **Índices**:
  - `Lot_name_key`: Índice único para el campo `name`.

### `Role`

- **Descripción**: Define los roles disponibles en el sistema.
- **Campos**:
  - `id`: Identificador único del rol (clave primaria).
  - `name`: Nombre del rol (tipo enumerado `Enum_RoleName`).
  - `createdAt`: Fecha y hora de creación.
  - `updatedAt`: Fecha y hora de la última actualización.
- **Índices**:
  - `Role_name_key`: Índice único para el campo `name`.

### `TMP_Collection`

- **Descripción**: Tabla temporal para almacenar colecciones.
- **Campos**:
  - `id`: Identificador único de la colección.
  - `bunches`: Número de racimos.
  - `collectionDate`: Fecha de la colección.
  - `lot`: Identificador del lote.
  - `userId`: Identificador del usuario.
  - `shipmentId`: Identificador del envío.
  - `createdAt`: Fecha y hora de creación.
  - `updatedAt`: Fecha y hora de la última actualización.

### `VerificationToken`

- **Descripción**: Almacena tokens de verificación.
- **Campos**:
  - `identifier`: Identificador del token (parte de la clave única).
  - `token`: Valor del token (parte de la clave única).
  - `expires`: Fecha y hora de expiración del token.
- **Índices**:
  - `VerificationToken_identifier_token_key`: Índice único para `identifier` y `token`.
  - `VerificationToken_token_key`: Índice único para `token`.

### `_prisma_migrations`

- **Descripción**: Almacena el historial de migraciones de Prisma.
- **Campos**:
  - `id`: Identificador único de la migración (clave primaria).
  - `checksum`: Suma de verificación de la migración.
  - `finished_at`: Fecha y hora de finalización.
  - `migration_name`: Nombre de la migración.
  - `logs`: Registros de la migración.
  - `rolled_back_at`: Fecha y hora en que se revirtió la migración.
  - `started_at`: Fecha y hora de inicio (valor por defecto `now()`).
  - `applied_steps_count`: Número de pasos aplicados.

### `User`

- **Descripción**: Almacena información sobre los usuarios del sistema.
- **Campos**:
  - `id`: Identificador único del usuario (clave primaria).
  - `name`: Nombre del usuario.
  - `email`: Correo electrónico del usuario.
  - `emailVerified`: Fecha de verificación del correo electrónico.
  - `image`: Imagen del usuario.
  - `roleId`: Identificador del rol del usuario (clave foránea).
- **Índices**:
  - `User_email_key`: Índice único para el campo `email`.
- **Relaciones**:
  - `roleId` referencia `Role(id)`.

### `Account`

- **Descripción**: Almacena cuentas asociadas a usuarios.
- **Campos**:
  - `id`: Identificador único de la cuenta (clave primaria).
  - `userId`: Identificador del usuario (clave foránea).
  - `type`: Tipo de cuenta.
  - `provider`: Proveedor de la cuenta.
  - `providerAccountId`: Identificador de la cuenta en el proveedor.
  - `refresh_token`: Token de actualización.
  - `access_token`: Token de acceso.
  - `expires_at`: Fecha y hora de expiración.
  - `token_type`: Tipo de token.
  - `scope`: Ámbito del token.
  - `id_token`: Token de identificación.
  - `session_state`: Estado de la sesión.
- **Índices**:
  - `Account_provider_providerAccountId_key`: Índice único para `provider` y `providerAccountId`.
- **Relaciones**:
  - `userId` referencia `User(id)`.

### `Profile`

- **Descripción**: Almacena información de perfil de usuario.
- **Campos**:
  - `id`: Identificador único del perfil (clave primaria).
  - `document`: Documento del perfil.
  - `phoneNumber`: Número de teléfono.
  - `image`: Imagen del perfil.
  - `userId`: Identificador del usuario (clave foránea).
  - `createdAt`: Fecha y hora de creación.
  - `updatedAt`: Fecha y hora de la última actualización.
- **Índices**:
  - `Profile_document_key`: Índice único para `document`.
  - `Profile_userId_key`: Índice único para `userId`.
- **Relaciones**:
  - `userId` referencia `User(id)`.

### `Session`

- **Descripción**: Almacena sesiones de usuario.
- **Campos**:
  - `id`: Identificador único de la sesión (clave primaria).
  - `sessionToken`: Token de la sesión.
  - `userId`: Identificador del usuario (clave foránea).
  - `expires`: Fecha y hora de expiración.
- **Índices**:
  - `Session_sessionToken_key`: Índice único para `sessionToken`.
- **Relaciones**:
  - `userId` referencia `User(id)`.

### `Shipment`

- **Descripción**: Almacena información sobre los envíos.
- **Campos**:
  - `id`: Identificador único del envío (clave primaria).
  - `shippedBunches`: Número de racimos enviados.
  - `shipmentDate`: Fecha del envío.
  - `bunchWeight`: Peso del racimo.
  - `deliveredWeight`: Peso entregado.
  - `userId`: Identificador del usuario (clave foránea).
  - `createdAt`: Fecha y hora de creación.
  - `updatedAt`: Fecha y hora de la última actualización.
  - `shipmentCode`: Código del envío.
- **Índices**:
  - `Shipment_shipmentCode_key`: Índice único para `shipmentCode`.
- **Relaciones**:
  - `userId` referencia `User(id)`.

### `Collection`

- **Descripción**: Almacena información sobre las colecciones.
- **Campos**:
  - `id`: Identificador único de la colección (clave primaria).
  - `bunches`: Número de racimos.
  - `collectionDate`: Fecha de la colección.
  - `lotId`: Identificador del lote (clave foránea).
  - `userId`: Identificador del usuario (clave foránea).
  - `shipmentId`: Identificador del envío (clave foránea).
  - `createdAt`: Fecha y hora de creación.
  - `updatedAt`: Fecha y hora de la última actualización.
- **Índices**:
  - `Collection_collectionDate_lotId_key`: Índice único para `collectionDate` y `lotId`.
- **Relaciones**:
  - `lotId` referencia `Lot(id)`.
  - `shipmentId` referencia `Shipment(id)`.
  - `userId` referencia `User(id)`.

## Relaciones

- **`User` a `Role`**: Muchos usuarios pueden tener un rol (`roleId` en `User` referencia `Role(id)`).
- **`Account` a `User`**: Cada cuenta está asociada a un usuario (`userId` en `Account` referencia `User(id)`).
- **`Profile` a `User`**: Cada perfil está asociado a un usuario (`userId` en `Profile` referencia `User(id)`).
- **`Session` a `User`**: Cada sesión está asociada a un usuario (`userId` en `Session` referencia `User(id)`).
- **`Shipment` a `User`**: Cada envío está asociado a un usuario (`userId` en `Shipment` referencia `User(id)`).
- **`Collection` a `Lot`**: Cada colección está asociada a un lote (`lotId` en `Collection` referencia `Lot(id)`).
- **`Collection` a `Shipment`**: