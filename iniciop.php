<?php
// Conexión a la base de datos
$host = "localhost";
$dbname = "multisucursal";
$username = "root";
$password = "";

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=latin1", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Procesar el formulario de pedido
    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        $nombre_cliente = $_POST['nombre_cliente'] ?? '';
        $telefono_cliente = $_POST['telefono_cliente'] ?? '';
        $direccion_envio = $_POST['direccion_envio'] ?? '';

        // Convertir los artículos seleccionados en un array
        $articulosSeleccionados = !empty($_POST['articulos']) ? $_POST['articulos'] : [];

        // Validar si se seleccionaron artículos
        if (empty($articulosSeleccionados)) {
            echo "<p style='color:red;'>Por favor, seleccione al menos un artículo.</p>";
        } else {
            // Insertar el pedido en la base de datos
            $sql = "INSERT INTO pedido_online (nombre_cliente, telefono_cliente, direccion_envio) VALUES (:nombre_cliente, :telefono_cliente, :direccion_envio)";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                ':nombre_cliente' => $nombre_cliente,
                ':telefono_cliente' => $telefono_cliente,
                ':direccion_envio' => $direccion_envio,
            ]);

            // Obtener el ID del pedido recién creado
            $pedido_id = $pdo->lastInsertId();

            // Insertar cada artículo en la tabla de relación
            foreach ($articulosSeleccionados as $idarticulo) {
                $sqlArticulos = "INSERT INTO pedido_articulos (pedido_id, idarticulo) VALUES (:pedido_id, :idarticulo)";
                $stmtArticulos = $pdo->prepare($sqlArticulos);
                $stmtArticulos->execute([
                    ':pedido_id' => $pedido_id,
                    ':idarticulo' => $idarticulo,
                ]);
            }

            echo "<p>Pedido realizado con éxito.</p>";
        }
    }

    // Consulta para obtener los artículos (sin el campo precio)
    $sqlArticulos = "SELECT idarticulo, nombre, descripcion, imagen, estado FROM articulo";
    $stmtArticulos = $pdo->prepare($sqlArticulos);
    $stmtArticulos->execute();

    // HTML con estilos CSS
    echo '<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #333;
            text-align: center;
        }
        form {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #5cb85c;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #4cae4c;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .estado-activo {
            color: green;
        }
        .estado-inactivo {
            color: red;
        }
        @media (max-width: 600px) {
            body {
                padding: 10px;
            }
            form {
                padding: 15px;
            }
            input[type="text"], input[type="submit"] {
                font-size: 14px;
            }
            table {
                font-size: 14px;
            }
        }
    </style>';

    echo '<h2>Formulario de Pedido</h2>';
    echo '<form method="POST" action="">';
    echo 'Nombre del Cliente: <input type="text" name="nombre_cliente" required><br>';
    echo 'Teléfono: <input type="text" name="telefono_cliente" required><br>';
    echo 'Dirección de Envío: <input type="text" name="direccion_envio" required><br>';
    
    echo '<h3>Artículos Disponibles:</h3>';
    echo '<table>';
    echo '<tr><th>Nombre</th><th>Descripción</th><th>Imagen</th><th>Estado</th><th>Seleccionar</th></tr>';

    // Mostramos los artículos en una tabla HTML
    while ($row = $stmtArticulos->fetch(PDO::FETCH_ASSOC)) {
        $estadoClase = $row['estado'] === 'A' ? 'estado-activo' : 'estado-inactivo';
        echo '<tr>';
        echo "<td>" . htmlspecialchars($row['nombre']) . "</td>";
        echo "<td>" . htmlspecialchars($row['descripcion']) . "</td>";
        echo "<td>" . ($row['imagen'] ? "<img src='" . htmlspecialchars($row['imagen']) . "' alt='Imagen de " . htmlspecialchars($row['nombre']) . "' style='width:50px;'>" : 'Sin imagen') . "</td>";
        echo "<td class='$estadoClase'>" . ($row['estado'] === 'A' ? 'Activo' : 'Inactivo') . "</td>";
        echo "<td><input type='checkbox' name='articulos[]' value='" . htmlspecialchars($row['idarticulo']) . "'></td>"; // Checkbox para seleccionar
        echo '</tr>';
    }

    echo '</table>';
    echo '<input type="submit" value="Realizar Pedido">';
    echo '</form>';

} catch (PDOException $e) {
    echo "Error en la conexión: " . $e->getMessage();
}
?>
