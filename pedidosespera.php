<?php
// Conexión a la base de datos
$host = "localhost";
$dbname = "multisucursal";
$username = "root";
$password = "";

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=latin1", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Consulta para obtener los pedidos y los artículos relacionados
    $sql = "
        SELECT po.idpedido AS pedido_id, po.nombre_cliente, po.telefono_cliente, po.direccion_envio,
               pa.idarticulo, a.nombre AS nombre_articulo, a.descripcion, a.imagen
        FROM pedido_online po
        JOIN pedido_articulos pa ON po.idpedido = pa.pedido_id
        JOIN articulo a ON pa.idarticulo = a.idarticulo
        ORDER BY po.idpedido DESC, a.nombre;
    ";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $pedidos = $stmt->fetchAll(PDO::FETCH_GROUP | PDO::FETCH_ASSOC);

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
        .pedido {
            background: white;
            margin-bottom: 20px;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .botones {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        .boton {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .boton.eliminar {
            background-color: #e74c3c;
        }
    </style>';

    echo '<h2>Detalles de Pedidos en Espera</h2>';

    // Mostrar cada pedido y sus artículos asociados
    foreach ($pedidos as $pedido_id => $detalles) {
        $pedido = $detalles[0];
        echo '<div class="pedido">';
        echo "<h3>Pedido ID: " . htmlspecialchars($pedido_id) . "</h3>";
        echo "<p>Cliente: " . htmlspecialchars($pedido['nombre_cliente']) . "</p>";
        echo "<p>Teléfono: " . htmlspecialchars($pedido['telefono_cliente']) . "</p>";
        echo "<p>Dirección de Envío: " . htmlspecialchars($pedido['direccion_envio']) . "</p>";
        
        echo '<h4>Artículos:</h4>';
        echo '<table>';
        echo '<tr><th>Nombre</th><th>Descripción</th><th>Imagen</th></tr>';

        // Mostrar artículos de cada pedido
        foreach ($detalles as $articulo) {
            echo '<tr>';
            echo "<td>" . htmlspecialchars($articulo['nombre_articulo']) . "</td>";
            echo "<td>" . htmlspecialchars($articulo['descripcion']) . "</td>";
            echo "<td>" . ($articulo['imagen'] ? "<img src='" . htmlspecialchars($articulo['imagen']) . "' alt='Imagen de " . htmlspecialchars($articulo['nombre_articulo']) . "' style='width:50px;'>" : 'Sin imagen') . "</td>";
            echo '</tr>';
        }
        
        echo '</table>';

        // Botones para redirigir a Pedido.php y para finalizar la espera
        echo '<div class="botones">';
        echo "<a href='Pedido.php?action=realizar_venta&idpedido=" . htmlspecialchars($pedido_id) . "' class='boton'>Realizar Venta</a>";
        echo "<a href='?action=finalizar_espera&idpedido=" . htmlspecialchars($pedido_id) . "' class='boton eliminar'>Finalizar Espera</a>";
        echo '</div>';

        echo '</div>';
    }

    // Acción para eliminar un pedido cuando se pulsa "Finalizar Espera"
    if (isset($_GET['action']) && $_GET['action'] === 'finalizar_espera' && isset($_GET['idpedido'])) {
        $idpedido = $_GET['idpedido'];
        $sql = "DELETE FROM pedido_online WHERE idpedido = :idpedido";
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':idpedido', $idpedido, PDO::PARAM_INT);
        $stmt->execute();
        echo "<p>Pedido ID $idpedido eliminado correctamente.</p>";
    }
} catch (PDOException $e) {
    echo "Error en la conexión: " . $e->getMessage();
}
?>
