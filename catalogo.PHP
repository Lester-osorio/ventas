<?php
// Conexión a la base de datos
$host = "localhost";
$dbname = "multisucursal"; // Cambia a tu base de datos
$username = "root"; // Cambia a tu usuario
$password = ""; // Cambia a tu contraseña

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=latin1", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Consulta para obtener solo los campos necesarios de los artículos
    $sql = "SELECT nombre, descripcion, imagen, estado FROM articulo";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();

    // HTML con estilos CSS
    echo "<!DOCTYPE html>
    <html lang='es'>
    <head>
        <meta charset='UTF-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
        <title>Listado de Artículos</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .table-container {
                width: 90%;
                max-width: 1200px;
                margin: 20px auto;
                border-collapse: collapse;
                overflow-x: auto;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                border-radius: 8px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 12px;
                text-align: left;
            }
            th {
                background-color: #232f3e;
                color: #fff;
                font-weight: bold;
            }
            td {
                border-bottom: 1px solid #ddd;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            img {
                width: 80px;
                height: auto;
                border-radius: 4px;
            }
            .estado-activo {
                color: green;
                font-weight: bold;
            }
            .estado-inactivo {
                color: red;
                font-weight: bold;
            }
            @media (max-width: 768px) {
                th, td {
                    padding: 10px;
                    font-size: 0.9em;
                }
                img {
                    width: 60px;
                }
            }
            @media (max-width: 480px) {
                body {
                    padding: 10px;
                }
                .table-container {
                    width: 100%;
                }
                th, td {
                    font-size: 0.8em;
                    padding: 8px;
                }
                img {
                    width: 50px;
                }
            }
            .whatsapp-link {
                margin: 20px;
                text-align: center;
            }
            .whatsapp-link a {
                background-color: #25D366; /* Color de WhatsApp */
                color: white;
                padding: 10px 15px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
            }
            .pedido-button {
                margin: 20px;
                text-align: center;
            }
            .pedido-button a {
                background-color: #007bff; /* Color de botón */
                color: white;
                padding: 10px 15px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class='whatsapp-link'>
            <a href='https://wa.me/50232043218' target='_blank'>Contactar por WhatsApp</a>
        </div>
        <div class='pedido-button'>
            <a href='iniciop.php'>Iniciar Pedido</a>
        </div>
        <div class='table-container'>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Imagen</th>
                    <th>Estado</th>
                </tr>";

                // Mostramos los artículos en una tabla HTML
                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                    $estadoClase = $row['estado'] === 'A' ? 'estado-activo' : 'estado-inactivo';
                    echo "<tr>
                            <td>{$row['nombre']}</td>
                            <td>{$row['descripcion']}</td>
                            <td>" . ($row['imagen'] ? "<img src='{$row['imagen']}' alt='Imagen de {$row['nombre']}'>" : 'Sin imagen') . "</td>
                            <td class='{$estadoClase}'>" . ($row['estado'] === 'A' ? 'Activo' : 'Inactivo') . "</td>
                          </tr>";
                }

    echo "    </table>
        </div>
    </body>
    </html>";
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
