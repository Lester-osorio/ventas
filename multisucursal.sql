-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-10-2024 a las 22:57:01
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `multisucursal`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `idunidad_medida` int(11) NOT NULL,
  `nombre` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `descripcion` text CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `imagen` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `estado` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `idunidad_medida`, `nombre`, `descripcion`, `imagen`, `estado`) VALUES
(4561, 17, 1, 'Proyector Epson x12', 'Proyector Epson x12', 'Files/Articulo/Proyector Epson.jpg', 'A'),
(4562, 2, 1, 'Impresora Epson', 'Impresora Epson', 'Files/Articulo/Impresora Epson.jpg', 'N'),
(4564, 19, 1, 'PC', 'portatil i5', 'Files/Articulo/pc2.jpg', 'A'),
(4565, 19, 1, 'PC', 'portatil ', 'Files/Articulo/pc1.jpg', 'A'),
(4567, 19, 1, 'CHARROY', '', 'Files/Articulo/CU1.jpg', 'A'),
(4568, 2, 1, 'canon', 'buena impresora ', 'Files/Articulo/GM2010P.jpg', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `estado`) VALUES
(2, 'Impresoras', 'A'),
(17, 'Proyectores', 'A'),
(19, 'PC portatil', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credito`
--

CREATE TABLE `credito` (
  `idcredito` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `fecha_pago` date NOT NULL,
  `total_pago` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `credito`
--

INSERT INTO `credito` (`idcredito`, `idventa`, `fecha_pago`, `total_pago`) VALUES
(2, 9, '2024-08-24', 100.00),
(3, 9, '2024-08-24', 80.00),
(4, 11, '2024-08-24', 0.00),
(5, 11, '2024-08-24', 0.00),
(6, 13, '2024-08-24', 100.00),
(7, 18, '2024-10-24', 15000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_documento_sucursal`
--

CREATE TABLE `detalle_documento_sucursal` (
  `iddetalle_documento_sucursal` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idtipo_documento` int(11) NOT NULL,
  `ultima_serie` varchar(7) NOT NULL,
  `ultimo_numero` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `detalle_documento_sucursal`
--

INSERT INTO `detalle_documento_sucursal` (`iddetalle_documento_sucursal`, `idsucursal`, `idtipo_documento`, `ultima_serie`, `ultimo_numero`) VALUES
(1, 1, 3, '001', '00005'),
(2, 1, 6, '001', '0008'),
(3, 1, 7, '001', '0004'),
(4, 1, 9, '001', '00001');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `serie` varchar(50) DEFAULT NULL,
  `descripcion` varchar(1024) DEFAULT NULL,
  `stock_ingreso` int(11) NOT NULL,
  `stock_actual` int(11) NOT NULL,
  `precio_compra` decimal(8,2) NOT NULL,
  `utilidad` decimal(8,2) NOT NULL,
  `precio_ventadistribuidor` decimal(8,2) NOT NULL,
  `precio_ventapublico` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `detalle_ingreso`
--

INSERT INTO `detalle_ingreso` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `codigo`, `serie`, `descripcion`, `stock_ingreso`, `stock_actual`, `precio_compra`, `utilidad`, `precio_ventadistribuidor`, `precio_ventapublico`) VALUES
(6, 5, 4564, '', '', '', 100, 91, 100.00, 1.00, 160.00, 180.00),
(7, 6, 4564, '123456', 'asa12', 'es grande', 15, 10, 100.00, 600.00, 300.00, 700.00),
(8, 7, 4561, '200', 'dsa321', 'cdwlñfkwel', 10, 2, 500.00, 200.00, 600.00, 700.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `iddetalle_pedido` int(11) NOT NULL,
  `idpedido` int(11) NOT NULL,
  `iddetalle_ingreso` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(8,2) NOT NULL,
  `descuento` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`iddetalle_pedido`, `idpedido`, `iddetalle_ingreso`, `cantidad`, `precio_venta`, `descuento`) VALUES
(8, 7, 6, 1, 180.00, 0.00),
(9, 8, 7, 2, 700.00, 0.00),
(10, 9, 6, 1, 180.00, 0.00),
(11, 10, 6, 1, 180.00, 0.00),
(13, 12, 6, 1, 180.00, 0.00),
(14, 13, 6, 1, 180.00, 0.00),
(15, 14, 6, 1, 180.00, 0.00),
(16, 15, 6, 1, 180.00, 0.00),
(17, 16, 6, 1, 180.00, 0.00),
(18, 17, 6, 1, 180.00, 0.00),
(19, 18, 8, 1, 700.00, 5.00),
(20, 18, 6, 1, 180.00, 0.00),
(21, 19, 6, 1, 180.00, 0.00),
(22, 19, 7, 1, 700.00, 0.00),
(23, 19, 8, 1, 700.00, 0.00),
(24, 20, 6, 1, 180.00, 0.00),
(25, 20, 7, 1, 700.00, 0.00),
(26, 20, 8, 1, 700.00, 0.00),
(27, 21, 8, 5, 700.00, 0.00),
(28, 21, 7, 1, 700.00, 0.00),
(29, 22, 8, 1, 700.00, 0.00),
(30, 23, 6, 1, 180.00, 0.00),
(31, 24, 7, 1, 700.00, 0.00),
(32, 24, 8, 1, 700.00, 0.00),
(33, 25, 6, 1, 180.00, 0.00),
(34, 25, 6, 1, 180.00, 0.00),
(35, 25, 6, 1, 180.00, 0.00),
(36, 25, 6, 1, 180.00, 0.00),
(37, 25, 6, 1, 180.00, 0.00),
(38, 25, 6, 1, 180.00, 0.00),
(39, 25, 6, 1, 180.00, 0.00),
(40, 25, 6, 1, 180.00, 0.00),
(41, 25, 6, 1, 180.00, 0.00),
(42, 25, 6, 1, 180.00, 0.00),
(43, 25, 6, 1, 180.00, 0.00),
(44, 25, 6, 1, 180.00, 0.00),
(45, 25, 6, 1, 180.00, 0.00),
(46, 25, 7, 1, 700.00, 0.00),
(47, 25, 7, 1, 700.00, 0.00),
(48, 25, 7, 1, 700.00, 0.00),
(49, 25, 7, 1, 700.00, 0.00),
(50, 25, 7, 1, 700.00, 0.00),
(51, 25, 7, 1, 700.00, 0.00),
(52, 25, 7, 1, 700.00, 0.00),
(53, 25, 8, 1, 700.00, 0.00),
(54, 25, 8, 1, 700.00, 0.00),
(55, 25, 8, 1, 700.00, 0.00),
(56, 25, 8, 1, 700.00, 0.00),
(57, 25, 8, 1, 700.00, 0.00),
(58, 25, 8, 1, 700.00, 0.00),
(61, 26, 6, 1, 180.00, 0.00),
(62, 26, 7, 1, 700.00, 0.00),
(63, 26, 8, 1, 700.00, 0.00),
(64, 27, 8, 1, 700.00, 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `idempleado` int(11) NOT NULL,
  `apellidos` varchar(40) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(70) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `foto` varchar(50) NOT NULL,
  `login` varchar(50) NOT NULL,
  `clave` varchar(32) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idempleado`, `apellidos`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `fecha_nacimiento`, `foto`, `login`, `clave`, `estado`) VALUES
(1, 'Osorio', 'Lester', 'DPI', '47715777', 'Santa Cruz Del quiche', '35961153', 'froilantipaz@gmail.com', '2001-02-12', 'Files/Empleado/lester.jpg', 'lester', '21426b290d975ec5d264c38031da8fac', 'S'),
(3, 'Osorio', 'Kenneth', 'DPI', '3257434441401', '3ra av 14-16 zoan 4', '38065223', 'kenteh@gmail.com', '2013-08-11', 'Files/Empleado/kenneth.jpg', 'kenneth', '7ca955bd92ca8b00548ddf36d2e79217', 'A'),
(5, 'AJIATAZ', 'HENRY', 'DPI', '3262328701401', '8va calle 11 -145 zona 3', '58912004', 'hajiatazp@miumg.edu.gt', '1999-11-26', '', 'HENRY', '202cb962ac59075b964b07152d234b70', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `global`
--

CREATE TABLE `global` (
  `idglobal` int(11) NOT NULL,
  `empresa` varchar(100) NOT NULL,
  `nombre_impuesto` varchar(5) NOT NULL,
  `porcentaje_impuesto` decimal(5,2) NOT NULL,
  `simbolo_moneda` varchar(5) NOT NULL,
  `logo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `global`
--

INSERT INTO `global` (`idglobal`, `empresa`, `nombre_impuesto`, `porcentaje_impuesto`, `simbolo_moneda`, `logo`) VALUES
(1, 'ventas y servicios', 'IVA', 12.00, 'Q', 'Files/Global/ventasyservicios.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) NOT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha` date NOT NULL,
  `impuesto` decimal(8,2) NOT NULL,
  `utilidad` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`idingreso`, `idusuario`, `idsucursal`, `idproveedor`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha`, `impuesto`, `utilidad`, `total`, `estado`) VALUES
(4, 25, 1, 4, 'TICKET', '34343', '34343', '2024-07-27', 10.00, 300.00, 250.00, 'A'),
(5, 25, 1, 4, 'TICKET', '4334', '3343', '2024-07-27', 10.00, 80.00, 10000.00, 'A'),
(6, 25, 1, 1, 'FACTURA', '456', '3343', '2024-07-27', 10.00, 600.00, 1500.00, 'A'),
(7, 23, 1, 4, 'FACTURA', '001', '066', '2024-07-27', 10.00, 200.00, 5000.00, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `idpedido` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `tipo_pedido` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  `numero` int(11) DEFAULT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`idpedido`, `idcliente`, `idusuario`, `idsucursal`, `tipo_pedido`, `fecha`, `numero`, `estado`) VALUES
(7, 2, 25, 1, 'Venta', '2024-08-15', 1, 'A'),
(8, 2, 25, 1, 'Venta', '2024-08-15', 2, 'A'),
(9, 2, 25, 1, 'Venta', '2024-08-15', 3, 'A'),
(10, 2, 22, 1, 'Venta', '2024-08-15', 4, 'A'),
(12, 5, 22, 1, 'Venta', '2024-08-15', 6, 'A'),
(13, 5, 22, 1, 'Venta', '2024-08-15', 7, 'A'),
(14, 5, 22, 1, 'Venta', '2024-08-15', 8, 'C'),
(15, 5, 22, 1, 'Venta', '2024-08-15', 9, 'A'),
(16, 2, 22, 1, 'Venta', '2024-08-15', 10, 'A'),
(17, 2, 22, 1, 'Venta', '2024-08-15', 11, 'C'),
(18, 2, 22, 1, 'Pedido', '2024-08-15', 12, 'A'),
(19, 5, 22, 1, 'Venta', '2024-08-15', 13, 'A'),
(20, 2, 22, 1, 'Pedido', '2024-08-15', 14, 'A'),
(21, 2, 22, 1, 'Venta', '2024-08-15', 15, 'A'),
(22, 2, 22, 1, 'Pedido', '2024-10-23', 16, 'A'),
(23, 2, 22, 1, 'Pedido', '2024-10-23', 17, 'A'),
(24, 2, 22, 1, 'Pedido', '2024-10-23', 18, 'A'),
(25, 5, 22, 1, 'Venta', '2024-10-23', 19, 'A'),
(26, 5, 25, 1, 'Pedido', '2024-10-24', 20, 'A'),
(27, 2, 25, 1, 'Venta', '2024-10-24', 21, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_articulos`
--

CREATE TABLE `pedido_articulos` (
  `idpedido_articulo` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido_articulos`
--

INSERT INTO `pedido_articulos` (`idpedido_articulo`, `pedido_id`, `idarticulo`) VALUES
(26, 10, 4561),
(27, 10, 4565),
(28, 10, 4567),
(29, 11, 4561);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_online`
--

CREATE TABLE `pedido_online` (
  `idpedido` int(11) NOT NULL,
  `nombre_cliente` varchar(100) NOT NULL,
  `telefono_cliente` varchar(15) NOT NULL,
  `direccion_envio` text NOT NULL,
  `fecha_pedido` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido_online`
--

INSERT INTO `pedido_online` (`idpedido`, `nombre_cliente`, `telefono_cliente`, `direccion_envio`, `fecha_pedido`) VALUES
(10, 'prueba ', '31777543', 'santa cruz del quiche ', '2024-10-25 20:45:22'),
(11, 'hugo ', '45632515', 'santa cruz del quiche ', '2024-10-25 20:53:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion_departamento` varchar(45) DEFAULT NULL,
  `direccion_provincia` varchar(45) DEFAULT NULL,
  `direccion_distrito` varchar(45) DEFAULT NULL,
  `direccion_calle` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `numero_cuenta` varchar(32) DEFAULT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion_departamento`, `direccion_provincia`, `direccion_distrito`, `direccion_calle`, `telefono`, `email`, `numero_cuenta`, `estado`) VALUES
(1, 'Proveedor', 'Importaciones Santa Ana S.A.C.', 'DI', '12581369852', 'quiche', 'santa cruz', 'quiche', '9na', '257896', 'importaciones@gmail.com', '305871596336', 'A'),
(2, 'Cliente', 'Juan Carlos Arcila Diaz', 'DNI', '75489623', 'Chiclayo', 'Chiclayo', 'Chiclayo', 'Chiclayo', '245862', 'jcarlos.ad7@gmail.com', '', 'A'),
(4, 'Proveedor', 'compus SA', 'NIT', '46467646', 'GUATEMALA', 'ESCUINTLA', 'SANTA LUCIA', '4TA CALLE 5206', '464634616', 'COMPUS@GMAIL.COM', '34994839493', 'A'),
(5, 'Cliente', 'Nelson', 'CEDULA', '5724074', 'San Lorenzo', 'Central', 'ñññ', 'los naranjos', '0982286379', 'solisjonathan821@gmail.com', '', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `idsucursal` int(11) NOT NULL,
  `razon_social` varchar(150) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(70) DEFAULT NULL,
  `representante` varchar(150) DEFAULT NULL,
  `logo` varchar(50) DEFAULT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`idsucursal`, `razon_social`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `representante`, `logo`, `estado`) VALUES
(1, 'ventas y servicios 2', 'NIT', '325743444', 'Quetzaltenango', '30641612', 'ventasysoluciones2@gmail.com', 'Heidy Velasquez', 'Files/Sucursal/ventasyservicios.jpg', 'A'),
(2, 'ventas y servicios 1', 'NIT', '325743444', 'Santa Cruz del Quiche', '35961153', 'VENTASYSERVICIOS@GMAIL.COM', 'Lester Osorio', 'Files/Sucursal/ventasyservicios.jpg', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `idtipo_documento` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `operacion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `tipo_documento`
--

INSERT INTO `tipo_documento` (`idtipo_documento`, `nombre`, `operacion`) VALUES
(1, 'NIT', 'Persona'),
(2, 'DPI', 'Persona'),
(3, 'TICKET', 'Comprobante'),
(5, 'DI', 'Persona'),
(6, 'FACTURA', 'Comprobante'),
(7, 'BOLETA', 'Comprobante'),
(8, 'CEDULA', 'Persona'),
(9, 'GUIA-REMISION', 'Comprobante');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_medida`
--

CREATE TABLE `unidad_medida` (
  `idunidad_medida` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `prefijo` varchar(5) NOT NULL,
  `estado` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `unidad_medida`
--

INSERT INTO `unidad_medida` (`idunidad_medida`, `nombre`, `prefijo`, `estado`) VALUES
(1, 'Unidad', 'Und', 'A'),
(2, 'Caja', 'Cja', 'A'),
(3, 'Paquete', 'Pqt', 'A'),
(4, 'Metro', 'Mt', 'A'),
(5, 'Docena', 'Doc', 'A'),
(6, 'Decena', 'Dec', 'A'),
(7, 'Ciento', 'Cto', 'A'),
(9, 'Paquete x 10', 'PQ10', 'A'),
(10, 'PC', 'uni', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idempleado` int(11) NOT NULL,
  `tipo_usuario` varchar(20) NOT NULL,
  `fecha_registro` date NOT NULL,
  `mnu_almacen` varchar(1) NOT NULL,
  `mnu_compras` varchar(1) NOT NULL,
  `mnu_ventas` varchar(1) NOT NULL,
  `mnu_mantenimiento` varchar(1) NOT NULL,
  `mnu_seguridad` varchar(1) NOT NULL,
  `mnu_consulta_compras` varchar(1) NOT NULL,
  `mnu_consulta_ventas` varchar(1) NOT NULL,
  `mnu_admin` varchar(1) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `idsucursal`, `idempleado`, `tipo_usuario`, `fecha_registro`, `mnu_almacen`, `mnu_compras`, `mnu_ventas`, `mnu_mantenimiento`, `mnu_seguridad`, `mnu_consulta_compras`, `mnu_consulta_ventas`, `mnu_admin`, `estado`) VALUES
(22, 1, 1, 'Administrador', '2024-08-25', '1', '1', '1', '1', '1', '1', '1', '1', 'A'),
(23, 2, 3, 'Empleado', '2024-08-26', '1', '1', '1', '1', '1', '1', '1', '1', 'A'),
(25, 1, 5, 'Empleado', '2024-08-27', '1', '1', '1', '0', '0', '1', '1', '0', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idpedido` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_venta` varchar(20) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) NOT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha` date NOT NULL,
  `impuesto` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`idventa`, `idpedido`, `idusuario`, `tipo_venta`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha`, `impuesto`, `total`, `estado`) VALUES
(5, 7, 25, 'Contado', 'TICKET', '001', '00001', '2021-11-27', 10.00, 180.00, 'A'),
(6, 8, 25, 'Contado', 'FACTURA', '001', '0001', '2021-11-27', 10.00, 1400.00, 'A'),
(7, 9, 25, 'Contado', 'FACTURA', '001', '0002', '2021-11-29', 10.00, 180.00, 'A'),
(8, 10, 22, 'Contado', 'BOLETA', '001', '0001', '2021-11-29', 10.00, 180.00, 'A'),
(9, 12, 22, 'Credito', 'FACTURA', '001', '0003', '2021-11-30', 10.00, 180.00, 'A'),
(10, 13, 22, 'Contado', 'FACTURA', '001', '0004', '2021-11-30', 10.00, 180.00, 'A'),
(11, 14, 22, 'Credito', 'FACTURA', '001', '0005', '2021-11-30', 0.00, 0.00, 'A'),
(12, 15, 22, 'Contado', 'BOLETA', '001', '0002', '2021-11-30', 10.00, 180.00, 'A'),
(13, 16, 22, 'Credito', 'BOLETA', '001', '0003', '2021-11-30', 10.00, 180.00, 'A'),
(14, 17, 22, 'Contado', 'FACTURA', '001', '0006', '2021-12-02', 0.00, 0.00, 'A'),
(15, 19, 22, 'Contado', 'TICKET', '001', '00002', '2022-11-10', 10.00, 1580.00, 'A'),
(16, 21, 22, 'Contado', 'FACTURA', '001', '0007', '2023-01-17', 10.00, 4200.00, 'A'),
(17, 25, 22, 'Contado', 'TICKET', '001', '00003', '2024-10-23', 12.00, 11440.00, 'A'),
(18, 27, 25, 'Credito', 'TICKET', '001', '00004', '2024-10-24', 12.00, 700.00, 'A'),
(19, 26, 25, 'Contado', '--Seleccione Comprob', '555', '55', '2024-10-24', 12.00, 1580.00, 'A');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD KEY `fk_articulo_categoria_idx` (`idcategoria`),
  ADD KEY `fk_articulo_unidad_medida_idx` (`idunidad_medida`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`);

--
-- Indices de la tabla `credito`
--
ALTER TABLE `credito`
  ADD PRIMARY KEY (`idcredito`),
  ADD KEY `fk_credito_venta1_idx` (`idventa`);

--
-- Indices de la tabla `detalle_documento_sucursal`
--
ALTER TABLE `detalle_documento_sucursal`
  ADD PRIMARY KEY (`iddetalle_documento_sucursal`),
  ADD KEY `fk_documento_sucursal_idx` (`idtipo_documento`),
  ADD KEY `fk_detalle_sucursal_idx` (`idsucursal`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_articulo_idx` (`idarticulo`),
  ADD KEY `fk_detalle_ingreso_idx` (`idingreso`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`iddetalle_pedido`),
  ADD KEY `fk_detalle_venta_ingreso_idx` (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_venta_idx` (`idpedido`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idempleado`);

--
-- Indices de la tabla `global`
--
ALTER TABLE `global`
  ADD PRIMARY KEY (`idglobal`),
  ADD UNIQUE KEY `empresa_UNIQUE` (`empresa`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_proveedor_idx` (`idproveedor`),
  ADD KEY `fk_ingreso_usuario_idx` (`idusuario`),
  ADD KEY `fk_ingreso_sucursal_idx` (`idsucursal`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`idpedido`),
  ADD KEY `fk_venta_cliente_idx` (`idcliente`),
  ADD KEY `fk_venta_trabajador_idx` (`idusuario`),
  ADD KEY `fk_pedido_sucursal_idx` (`idsucursal`);

--
-- Indices de la tabla `pedido_articulos`
--
ALTER TABLE `pedido_articulos`
  ADD PRIMARY KEY (`idpedido_articulo`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `idarticulo` (`idarticulo`);

--
-- Indices de la tabla `pedido_online`
--
ALTER TABLE `pedido_online`
  ADD PRIMARY KEY (`idpedido`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`idsucursal`);

--
-- Indices de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`idtipo_documento`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  ADD PRIMARY KEY (`idunidad_medida`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD KEY `fk_usuario_empleado_idx` (`idempleado`),
  ADD KEY `fk_usuario_sucursal_idx` (`idsucursal`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_pedido_idx` (`idpedido`),
  ADD KEY `fk_venta_usuario_idx` (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4569;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `credito`
--
ALTER TABLE `credito`
  MODIFY `idcredito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_documento_sucursal`
--
ALTER TABLE `detalle_documento_sucursal`
  MODIFY `iddetalle_documento_sucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `iddetalle_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idempleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `global`
--
ALTER TABLE `global`
  MODIFY `idglobal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `idpedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `pedido_articulos`
--
ALTER TABLE `pedido_articulos`
  MODIFY `idpedido_articulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `pedido_online`
--
ALTER TABLE `pedido_online`
  MODIFY `idpedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `idsucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `idtipo_documento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  MODIFY `idunidad_medida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`),
  ADD CONSTRAINT `fk_articulo_unidad_medida` FOREIGN KEY (`idunidad_medida`) REFERENCES `unidad_medida` (`idunidad_medida`);

--
-- Filtros para la tabla `credito`
--
ALTER TABLE `credito`
  ADD CONSTRAINT `fk_credito_venta1` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`);

--
-- Filtros para la tabla `detalle_documento_sucursal`
--
ALTER TABLE `detalle_documento_sucursal`
  ADD CONSTRAINT `fk_detalle_sucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`),
  ADD CONSTRAINT `fk_documento_sucursal` FOREIGN KEY (`idtipo_documento`) REFERENCES `tipo_documento` (`idtipo_documento`);

--
-- Filtros para la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fk_detalle_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`),
  ADD CONSTRAINT `fk_detalle_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`);

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `fk_detalle_pedido` FOREIGN KEY (`idpedido`) REFERENCES `pedido` (`idpedido`),
  ADD CONSTRAINT `fk_detalle_pedido_ingreso` FOREIGN KEY (`iddetalle_ingreso`) REFERENCES `detalle_ingreso` (`iddetalle_ingreso`);

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_proveedor` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`),
  ADD CONSTRAINT `fk_ingreso_sucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`),
  ADD CONSTRAINT `fk_ingreso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`),
  ADD CONSTRAINT `fk_pedido_sucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`),
  ADD CONSTRAINT `fk_pedido_trabajador` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `pedido_articulos`
--
ALTER TABLE `pedido_articulos`
  ADD CONSTRAINT `pedido_articulos_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido_online` (`idpedido`) ON DELETE CASCADE,
  ADD CONSTRAINT `pedido_articulos_ibfk_2` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_empleado` FOREIGN KEY (`idempleado`) REFERENCES `empleado` (`idempleado`),
  ADD CONSTRAINT `fk_usuario_sucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_pedido` FOREIGN KEY (`idpedido`) REFERENCES `pedido` (`idpedido`),
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
