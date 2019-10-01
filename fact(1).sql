-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-10-2019 a las 16:17:09
-- Versión del servidor: 10.4.6-MariaDB
-- Versión de PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `fact`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campoadicional`
--

CREATE TABLE `campoadicional` (
  `id` int(11) NOT NULL,
  `nombre` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `valor` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `Factura_id` int(11) DEFAULT NULL,
  `NotaCredito_id` int(11) DEFAULT NULL,
  `NotaDebito_id` int(11) DEFAULT NULL,
  `Retencion_id` int(11) DEFAULT NULL,
  `Guia_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `emisor_id` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tipoIdentificacion` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `identificacion` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `direccion` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `celular` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `correoElectronico` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `emisor_id`, `nombre`, `tipoIdentificacion`, `identificacion`, `direccion`, `celular`, `correoElectronico`, `createdAt`, `updatedAt`, `createdBy_id`, `updatedBy_id`, `deletedBy_id`) VALUES
(9, 5, 'DANNY CEDEÑO', '04', '0930087465001', 'CUENCA', '0999999999', 'DANNY.PATO@OUTLOOK.COM', '2019-08-14 14:01:03', '2019-08-14 14:02:48', 6, 6, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentaporcobrar`
--

CREATE TABLE `cuentaporcobrar` (
  `id` int(11) NOT NULL,
  `fachaReguistro` date NOT NULL,
  `fechaVencimiento` date NOT NULL,
  `monto` decimal(11,2) NOT NULL,
  `abono` decimal(11,2) NOT NULL,
  `factura_id` int(11) NOT NULL,
  `saldo` decimal(11,2) NOT NULL,
  `formapag_id` int(11) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `observaciones` varchar(100) NOT NULL,
  `cliente_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cuentaporcobrar`
--

INSERT INTO `cuentaporcobrar` (`id`, `fachaReguistro`, `fechaVencimiento`, `monto`, `abono`, `factura_id`, `saldo`, `formapag_id`, `estado`, `observaciones`, `cliente_id`) VALUES
(4, '0000-00-00', '0000-00-00', '16.25', '0.00', 17, '0.00', 0, '', '', 9);

--
-- Disparadores `cuentaporcobrar`
--
DELIMITER $$
CREATE TRIGGER `abonar` BEFORE INSERT ON `cuentaporcobrar` FOR EACH ROW BEGIN
    IF New.abono>0 THEN set New.saldo=New.monto -New.abono;
    ELSE set New.saldo=New.abono;
    end if;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `edit_abonar` BEFORE UPDATE ON `cuentaporcobrar` FOR EACH ROW BEGIN
    IF New.abono>0 THEN set New.saldo=New.monto -New.abono;
    ELSE set New.saldo=New.abono;
    end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleadicional`
--

CREATE TABLE `detalleadicional` (
  `id` int(11) NOT NULL,
  `nombre` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `valor` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `facturaHasProducto_id` int(11) DEFAULT NULL,
  `notaCreditoHasProducto_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emisor`
--

CREATE TABLE `emisor` (
  `id` int(11) NOT NULL,
  `ruc` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `ambiente` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `tipoEmision` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `razonSocial` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `nombreComercial` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccionMatriz` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `contribuyenteEspecial` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `obligadoContabilidad` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `dirLogo` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `dirFirma` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `dirDocAutorizados` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `passFirma` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `servidorCorreo` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `correoRemitente` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `passCorreo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `puerto` int(11) NOT NULL,
  `SSLHabilitado` tinyint(1) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL,
  `plan_id` int(11) DEFAULT NULL,
  `cantComprobante` int(11) NOT NULL,
  `fechaInicio` date DEFAULT NULL,
  `fechaFin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `emisor`
--

INSERT INTO `emisor` (`id`, `ruc`, `ambiente`, `tipoEmision`, `razonSocial`, `nombreComercial`, `direccionMatriz`, `contribuyenteEspecial`, `obligadoContabilidad`, `dirLogo`, `dirFirma`, `dirDocAutorizados`, `passFirma`, `servidorCorreo`, `correoRemitente`, `passCorreo`, `puerto`, `SSLHabilitado`, `activo`, `createdAt`, `updatedAt`, `createdBy_id`, `updatedBy_id`, `deletedBy_id`, `plan_id`, `cantComprobante`, `fechaInicio`, `fechaFin`) VALUES
(5, '0301568283001', '1', '1', 'CALLE RUBIO CRISTIAN FERNANDO', 'INFAMED TECNOLOGIA', 'AV PASEO DE LOS CANARIS 4 -120 Y LUIS LARREA ALBA', NULL, 'NO', '/Clientes1/EasyPOS-128.png', '/Clientes1/P0000022049.p12', '/Clientes1', 'LIadPw80ki', 'smtp.gmail.com', 'cristianfcalle@gmail.com', 'sebas0956999721', 465, 1, 1, '2019-08-14 13:54:27', '2019-08-14 16:43:14', NULL, 6, NULL, NULL, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `establecimiento`
--

CREATE TABLE `establecimiento` (
  `id` int(11) NOT NULL,
  `emisor_id` int(11) NOT NULL,
  `nombre` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `urlweb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nombreComercial` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccion` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL,
  `dirLogo` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `establecimiento`
--

INSERT INTO `establecimiento` (`id`, `emisor_id`, `nombre`, `codigo`, `urlweb`, `nombreComercial`, `direccion`, `activo`, `createdAt`, `updatedAt`, `createdBy_id`, `updatedBy_id`, `deletedBy_id`, `dirLogo`) VALUES
(5, 5, 'matriz', '001', NULL, 'INFAMED TECNOLOGIA', 'AV PASEO DE LOS CANARIS 4-120 Y LUIS LARREA ALBA', 1, '2019-08-14 13:56:20', '2019-08-14 13:56:20', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `emisor_id` int(11) NOT NULL,
  `establecimiento_id` int(11) NOT NULL,
  `claveAcceso` varchar(49) COLLATE utf8_unicode_ci NOT NULL,
  `numeroAutorizacion` varchar(49) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fechaAutorizacion` datetime DEFAULT NULL,
  `estado` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ambiente` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `tipoEmision` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `secuencial` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `formaPago` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `fechaEmision` date NOT NULL,
  `nombreArchivo` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `totalSinImpuestos` decimal(10,2) NOT NULL,
  `subtotal12` decimal(10,2) NOT NULL,
  `subtotal0` decimal(10,2) NOT NULL,
  `subtotalNoIVA` decimal(10,2) NOT NULL,
  `subtotalExentoIVA` decimal(10,2) NOT NULL,
  `valorICE` decimal(10,2) NOT NULL,
  `valorIRBPNR` decimal(10,2) NOT NULL,
  `iva12` decimal(10,2) NOT NULL,
  `totalDescuento` decimal(10,2) NOT NULL,
  `propina` decimal(10,2) NOT NULL,
  `valorTotal` decimal(10,2) NOT NULL,
  `monto` decimal(11,2) NOT NULL,
  `ctaContable` int(11) NOT NULL,
  `banco` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `abono` decimal(11,2) NOT NULL,
  `saldo` decimal(11,2) NOT NULL,
  `estadoCuenta` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `firmado` tinyint(1) NOT NULL,
  `enviarSiAutorizado` tinyint(1) NOT NULL,
  `observacion` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `ptoEmision_id` int(11) NOT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id`, `cliente_id`, `emisor_id`, `establecimiento_id`, `claveAcceso`, `numeroAutorizacion`, `fechaAutorizacion`, `estado`, `ambiente`, `tipoEmision`, `secuencial`, `formaPago`, `fechaEmision`, `nombreArchivo`, `totalSinImpuestos`, `subtotal12`, `subtotal0`, `subtotalNoIVA`, `subtotalExentoIVA`, `valorICE`, `valorIRBPNR`, `iva12`, `totalDescuento`, `propina`, `valorTotal`, `monto`, `ctaContable`, `banco`, `abono`, `saldo`, `estadoCuenta`, `firmado`, `enviarSiAutorizado`, `observacion`, `createdAt`, `updatedAt`, `ptoEmision_id`, `createdBy_id`, `updatedBy_id`, `deletedBy_id`) VALUES
(17, 9, 5, 5, '1408201901030156828300120010010000000001234567814', '1408201901030156828300120010010000000001234567814', '2019-08-14 07:02:46', 'AUTORIZADO', '2', '1', '000000000', '01', '2019-08-14', 'FAC001-001-000000000', '1.00', '1.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.12', '0.00', '0.00', '1.12', '150.25', 0, '', '0.50', '149.75', 'PENDIENTE', 1, 1, '', '2019-08-14 14:02:10', '2019-08-14 14:02:56', 5, 6, 6, NULL),
(18, 9, 5, 5, '1408201901030156828300120010010000000011234567811', '1408201901030156828300120010010000000011234567811', '2019-08-14 09:43:05', 'AUTORIZADO', '2', '1', '000000001', '20', '2019-08-14', 'FAC001-001-000000001', '1.00', '1.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.12', '0.00', '0.00', '1.12', '15.25', 0, '', '2.00', '13.25', 'PENDIENTE', 1, 0, 'PAGO LAPTOP', '2019-08-14 16:42:49', '2019-08-14 16:43:14', 5, 6, 6, NULL),
(19, 9, 5, 5, '2308201901030156828300110010010000000021234567816', '2308201901030156828300110010010000000021234567816', '2019-08-23 03:08:18', 'AUTORIZADO', '1', '1', '000000002', '20', '2019-08-23', 'FAC001-001-000000002', '1.00', '1.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.12', '0.00', '0.00', '1.12', '19.75', 0, '', '18.00', '1.75', 'PENDIENTE', 1, 1, 'TODO OKay', '2019-08-23 22:05:40', '2019-08-23 22:09:23', 5, 6, 6, NULL),
(20, 9, 5, 5, '2509201901030156828300110010010000000031234567817', NULL, NULL, 'CREADA', '1', '1', '000000003', '15', '2019-09-25', NULL, '1.00', '1.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.12', '0.00', '0.00', '1.12', '19.50', 0, '', '19.50', '0.00', 'CANCELADO', 0, 0, 'eemplo', '2019-09-16 18:24:31', '2019-09-16 18:24:31', 5, 6, 6, NULL);

--
-- Disparadores `factura`
--
DELIMITER $$
CREATE TRIGGER `abonos` BEFORE INSERT ON `factura` FOR EACH ROW BEGIN
    IF New.abono>0 
    THEN set New.saldo=New.monto -New.abono;
    ELSE SET NEW.saldo=new.monto;
    end if;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `edit_abonos` BEFORE UPDATE ON `factura` FOR EACH ROW BEGIN
    IF New.abono>0 
    THEN set New.saldo=New.monto -New.abono;
    ELSE SET NEW.saldo=new.monto;
    end if;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `edit_estadosald` BEFORE UPDATE ON `factura` FOR EACH ROW BEGIN
    IF New.saldo>0 
    THEN set New.estadoCuenta='PENDIENTE';
    ELSE SET New.estadoCuenta='CANCELADO';
    end if;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `estado_saldo` BEFORE INSERT ON `factura` FOR EACH ROW BEGIN
    IF New.saldo>0 
    THEN set New.estadoCuenta='PENDIENTE';
    ELSE SET New.estadoCuenta='CANCELADO';
    end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturahasproducto`
--

CREATE TABLE `facturahasproducto` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `factura_id` int(11) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `nombre` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `codigoProducto` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `precioUnitario` decimal(10,2) NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `valorTotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `facturahasproducto`
--

INSERT INTO `facturahasproducto` (`id`, `producto_id`, `factura_id`, `cantidad`, `nombre`, `codigoProducto`, `precioUnitario`, `descuento`, `valorTotal`) VALUES
(30, 19, 17, '1.00', 'ASUS LAPTOP', '0090', '1.00', '0.00', '1.00'),
(31, 19, 18, '1.00', 'ASUS LAPTOP', '0090', '1.00', '0.00', '1.00'),
(32, 19, 19, '1.00', 'ASUS LAPTOP', '0090', '1.00', '0.00', '1.00'),
(33, 19, 20, '1.00', 'ASUS LAPTOP', '0090', '1.00', '0.00', '1.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formapago`
--

CREATE TABLE `formapago` (
  `id` int(11) NOT NULL,
  `descrpFormaPago` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `guia`
--

CREATE TABLE `guia` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `emisor_id` int(11) NOT NULL,
  `establecimiento_id` int(11) NOT NULL,
  `claveAcceso` varchar(49) COLLATE utf8_unicode_ci NOT NULL,
  `numeroAutorizacion` varchar(49) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fechaAutorizacion` datetime DEFAULT NULL,
  `estado` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ambiente` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `tipoEmision` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `secuencial` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `nombreArchivo` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dirPartida` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `razonSocialTransportista` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rucTransportista` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `fechaIniTransporte` date NOT NULL,
  `fechaFinTransporte` date NOT NULL,
  `placa` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `motivoTraslado` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `firmado` tinyint(1) NOT NULL,
  `enviarSiAutorizado` tinyint(1) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `ptoEmision_id` int(11) NOT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `guiahasproducto`
--

CREATE TABLE `guiahasproducto` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `guia_id` int(11) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `nombre` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `codigoProducto` varchar(300) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuesto`
--

CREATE TABLE `impuesto` (
  `id` int(11) NOT NULL,
  `codigo` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `codigoPorcentaje` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `tarifa` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `baseImponible` decimal(10,2) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `facturaHasProducto_id` int(11) DEFAULT NULL,
  `notaCreditoHasProducto_id` int(11) DEFAULT NULL,
  `notaDebito_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `impuesto`
--

INSERT INTO `impuesto` (`id`, `codigo`, `codigoPorcentaje`, `tarifa`, `baseImponible`, `valor`, `facturaHasProducto_id`, `notaCreditoHasProducto_id`, `notaDebito_id`) VALUES
(94, '2', '2', '12.00', '25.00', '3.00', 14, NULL, NULL),
(95, '2', '2', '12.00', '45.00', '5.40', 15, NULL, NULL),
(97, '2', '2', '12.00', '350.00', '42.00', 17, NULL, NULL),
(98, '2', '2', '12.00', '122.00', '14.64', 18, NULL, NULL),
(99, '2', '2', '12.00', '141.75', '17.01', 19, NULL, NULL),
(100, '2', '2', '12.00', '33.58', '4.03', 20, NULL, NULL),
(101, '2', '2', '12.00', '53.00', '6.36', 21, NULL, NULL),
(102, '2', '2', '12.00', '350.00', '42.00', 22, NULL, NULL),
(104, '2', '2', '12.00', '15.00', '1.80', 24, NULL, NULL),
(105, '2', '2', '12.00', '30.00', '3.60', 25, NULL, NULL),
(106, '2', '2', '12.00', '16.90', '2.03', 26, NULL, NULL),
(107, '2', '2', '12.00', '22.40', '2.69', 27, NULL, NULL),
(108, '2', '2', '12.00', '15.00', '1.80', 28, NULL, NULL),
(110, '2', '2', '12.00', '1.00', '0.12', 30, NULL, NULL),
(111, '2', '2', '12.00', '1.00', '0.12', 31, NULL, NULL),
(112, '2', '2', '12.00', '1.00', '0.12', 32, NULL, NULL),
(113, '2', '2', '12.00', '1.00', '0.12', 33, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuestocomprobanteretencion`
--

CREATE TABLE `impuestocomprobanteretencion` (
  `id` int(11) NOT NULL,
  `retencion_id` int(11) NOT NULL,
  `codigo` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `codigoRetencion` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `baseImponible` decimal(10,2) NOT NULL,
  `porcentajeRetener` int(11) NOT NULL,
  `valorRetenido` decimal(10,2) NOT NULL,
  `codDocSustento` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `numDocSustento` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `fechaEmisionDocSustento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuestoice`
--

CREATE TABLE `impuestoice` (
  `id` int(11) NOT NULL,
  `codigoPorcentaje` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuestoirbpnr`
--

CREATE TABLE `impuestoirbpnr` (
  `id` int(11) NOT NULL,
  `codigoPorcentaje` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuestoiva`
--

CREATE TABLE `impuestoiva` (
  `id` int(11) NOT NULL,
  `codigoPorcentaje` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tarifa` decimal(10,2) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `impuestoiva`
--

INSERT INTO `impuestoiva` (`id`, `codigoPorcentaje`, `nombre`, `tarifa`, `createdAt`, `updatedAt`, `createdBy_id`, `updatedBy_id`, `deletedBy_id`) VALUES
(1, '2', 'IVA 12%', '12.00', '2018-08-05 05:18:38', '2018-08-05 05:18:38', NULL, NULL, NULL),
(2, '0', 'IVA 0%', '0.00', '2018-08-05 05:20:22', '2018-08-05 05:20:22', NULL, NULL, NULL),
(3, '7', 'Exento de IVA', '0.00', '2018-08-05 14:20:52', '2018-08-05 14:20:52', NULL, NULL, NULL),
(4, '6', 'No Objeto de Impuesto', '0.00', '2018-08-05 14:21:25', '2018-08-05 14:21:25', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensaje`
--

CREATE TABLE `mensaje` (
  `id` int(11) NOT NULL,
  `identificador` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `mensaje` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `informacionAdicional` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `Factura_id` int(11) DEFAULT NULL,
  `NotaCredito_id` int(11) DEFAULT NULL,
  `NotaDebito_id` int(11) DEFAULT NULL,
  `Retencion_id` int(11) DEFAULT NULL,
  `Guia_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivo`
--

CREATE TABLE `motivo` (
  `id` int(11) NOT NULL,
  `nombre` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `dotaDebito_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notacredito`
--

CREATE TABLE `notacredito` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `emisor_id` int(11) NOT NULL,
  `establecimiento_id` int(11) NOT NULL,
  `claveAcceso` varchar(49) COLLATE utf8_unicode_ci NOT NULL,
  `numeroAutorizacion` varchar(49) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fechaAutorizacion` datetime DEFAULT NULL,
  `estado` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ambiente` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `tipoEmision` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `secuencial` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `fechaEmision` date NOT NULL,
  `tipoDocMod` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `fechaEmisionDocMod` date NOT NULL,
  `nroDocMod` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `motivo` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `nombreArchivo` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `totalSinImpuestos` decimal(10,2) NOT NULL,
  `subtotal12` decimal(10,2) NOT NULL,
  `subtotal0` decimal(10,2) NOT NULL,
  `subtotalNoIVA` decimal(10,2) NOT NULL,
  `subtotalExentoIVA` decimal(10,2) NOT NULL,
  `valorICE` decimal(10,2) NOT NULL,
  `valorIRBPNR` decimal(10,2) NOT NULL,
  `iva12` decimal(10,2) NOT NULL,
  `totalDescuento` decimal(10,2) NOT NULL,
  `valorTotal` decimal(10,2) NOT NULL,
  `firmado` tinyint(1) NOT NULL,
  `enviarSiAutorizado` tinyint(1) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `ptoEmision_id` int(11) NOT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notacreditohasproducto`
--

CREATE TABLE `notacreditohasproducto` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `nombre` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `codigoProducto` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `precioUnitario` decimal(10,2) NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `valorTotal` decimal(10,2) NOT NULL,
  `notaCredito_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notadebito`
--

CREATE TABLE `notadebito` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `emisor_id` int(11) NOT NULL,
  `establecimiento_id` int(11) NOT NULL,
  `claveAcceso` varchar(49) COLLATE utf8_unicode_ci NOT NULL,
  `numeroAutorizacion` varchar(49) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fechaAutorizacion` datetime DEFAULT NULL,
  `estado` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ambiente` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `tipoEmision` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `secuencial` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `fechaEmision` date NOT NULL,
  `tipoDocMod` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `fechaEmisionDocMod` date NOT NULL,
  `nroDocMod` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nombreArchivo` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `totalSinImpuestos` decimal(10,2) NOT NULL,
  `subtotal12` decimal(10,2) NOT NULL,
  `subtotal0` decimal(10,2) NOT NULL,
  `subtotalNoIVA` decimal(10,2) NOT NULL,
  `subtotalExentoIVA` decimal(10,2) NOT NULL,
  `valorICE` decimal(10,2) NOT NULL,
  `iva12` decimal(10,2) NOT NULL,
  `valorTotal` decimal(10,2) NOT NULL,
  `firmado` tinyint(1) NOT NULL,
  `enviarSiAutorizado` tinyint(1) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `ptoEmision_id` int(11) NOT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan`
--

CREATE TABLE `plan` (
  `id` int(11) NOT NULL,
  `cantComprobante` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `periodo` varchar(49) COLLATE utf8_unicode_ci NOT NULL,
  `observaciones` longtext COLLATE utf8_unicode_ci NOT NULL,
  `activo` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `plan`
--

INSERT INTO `plan` (`id`, `cantComprobante`, `precio`, `periodo`, `observaciones`, `activo`) VALUES
(1, 100, '20.00', 'Anual', 'Plan Inicial', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `emisor_id` int(11) NOT NULL,
  `impuesto_iva_id` int(11) NOT NULL,
  `impuesto_ice_id` int(11) DEFAULT NULL,
  `impuesto_irbpnr_id` int(11) DEFAULT NULL,
  `codigoPrincipal` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `codigoAuxiliar` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nombre` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `precioUnitario` decimal(10,2) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `emisor_id`, `impuesto_iva_id`, `impuesto_ice_id`, `impuesto_irbpnr_id`, `codigoPrincipal`, `codigoAuxiliar`, `nombre`, `precioUnitario`, `createdAt`, `updatedAt`, `createdBy_id`, `updatedBy_id`, `deletedBy_id`) VALUES
(19, 5, 1, NULL, NULL, '0090', NULL, 'ASUS LAPTOP', '1.00', '2019-08-14 14:01:49', '2019-08-14 14:01:49', 6, 6, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ptoemision`
--

CREATE TABLE `ptoemision` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `establecimiento_id` int(11) NOT NULL,
  `nombre` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `secuencialFactura` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `secuencialNotaCredito` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `secuencialNotaDebito` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `secuencialGuiaRemision` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `secuencialRetencion` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `ptoemision`
--

INSERT INTO `ptoemision` (`id`, `user_id`, `establecimiento_id`, `nombre`, `codigo`, `secuencialFactura`, `secuencialNotaCredito`, `secuencialNotaDebito`, `secuencialGuiaRemision`, `secuencialRetencion`, `activo`, `createdAt`, `updatedAt`, `createdBy_id`, `updatedBy_id`, `deletedBy_id`) VALUES
(5, 6, 5, 'CAJA', '001', '4', '0', '0', '0', '0', 1, '2019-08-14 13:57:11', '2019-09-16 18:24:31', NULL, 6, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `retencion`
--

CREATE TABLE `retencion` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `emisor_id` int(11) NOT NULL,
  `establecimiento_id` int(11) NOT NULL,
  `claveAcceso` varchar(49) COLLATE utf8_unicode_ci NOT NULL,
  `numeroAutorizacion` varchar(49) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fechaAutorizacion` datetime DEFAULT NULL,
  `estado` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ambiente` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `tipoEmision` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `secuencial` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `fechaEmision` date NOT NULL,
  `periodoFiscal` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `nombreArchivo` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firmado` tinyint(1) NOT NULL,
  `enviarSiAutorizado` tinyint(1) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `ptoEmision_id` int(11) NOT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `role`
--

INSERT INTO `role` (`id`, `nombre`, `createdAt`, `updatedAt`, `createdBy_id`, `updatedBy_id`, `deletedBy_id`) VALUES
(1, 'ROLE_EMISOR_ADMIN', '2018-09-08 12:32:12', '2018-09-08 12:32:12', NULL, NULL, NULL),
(2, 'ROLE_ADMIN', '2018-09-08 12:32:28', '2018-09-08 12:32:28', NULL, NULL, NULL),
(3, 'ROLE_EMISOR', '2018-09-08 12:32:39', '2018-09-08 12:32:39', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `emisor_id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `apellidos` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `createdBy_id` int(11) DEFAULT NULL,
  `updatedBy_id` int(11) DEFAULT NULL,
  `deletedBy_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `emisor_id`, `rol_id`, `username`, `password`, `email`, `nombre`, `apellidos`, `salt`, `is_active`, `createdAt`, `updatedAt`, `createdBy_id`, `updatedBy_id`, `deletedBy_id`) VALUES
(6, 5, 1, 'DEMO', 'H+8/MO5QW4/F00QGREbAhYraYWEZVvzQI6r7QJiQOvfPh9hZl3OoYikkNRy89tfHyws0xnYd/xnCv+MgZHKLtw==', 'DEMO@GMAIL.COM', 'DEMO', 'DEMO', '8772eed83cd6382f3f2e06ce881a049e', 1, '2019-08-14 13:58:10', '2019-09-03 04:54:28', NULL, NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `campoadicional`
--
ALTER TABLE `campoadicional`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D7FF66CFBF127A8F` (`Factura_id`),
  ADD KEY `IDX_D7FF66CF51CA559D` (`NotaCredito_id`),
  ADD KEY `IDX_D7FF66CFBCB7242D` (`NotaDebito_id`),
  ADD KEY `IDX_D7FF66CF6A1F1F62` (`Retencion_id`),
  ADD KEY `IDX_D7FF66CFC9979183` (`Guia_id`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_3BA1A2B96BDF87DF` (`emisor_id`),
  ADD KEY `IDX_3BA1A2B93174800F` (`createdBy_id`),
  ADD KEY `IDX_3BA1A2B965FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_3BA1A2B963D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `cuentaporcobrar`
--
ALTER TABLE `cuentaporcobrar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `factura_id` (`factura_id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `detalleadicional`
--
ALTER TABLE `detalleadicional`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_87797196CE7FF8C7` (`facturaHasProducto_id`),
  ADD KEY `IDX_8779719698D062E6` (`notaCreditoHasProducto_id`);

--
-- Indices de la tabla `emisor`
--
ALTER TABLE `emisor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C30280783174800F` (`createdBy_id`),
  ADD KEY `IDX_C302807865FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_C302807863D8C20E` (`deletedBy_id`),
  ADD KEY `IDX_C3028078E899029B` (`plan_id`);

--
-- Indices de la tabla `establecimiento`
--
ALTER TABLE `establecimiento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1C61EFE06BDF87DF` (`emisor_id`),
  ADD KEY `IDX_1C61EFE03174800F` (`createdBy_id`),
  ADD KEY `IDX_1C61EFE065FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_1C61EFE063D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_36569995DE734E51` (`cliente_id`),
  ADD KEY `IDX_365699956BDF87DF` (`emisor_id`),
  ADD KEY `IDX_3656999571B61351` (`establecimiento_id`),
  ADD KEY `IDX_36569995E01B1B5E` (`ptoEmision_id`),
  ADD KEY `IDX_365699953174800F` (`createdBy_id`),
  ADD KEY `IDX_3656999565FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_3656999563D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `facturahasproducto`
--
ALTER TABLE `facturahasproducto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1CFCFE017645698E` (`producto_id`),
  ADD KEY `IDX_1CFCFE01F04F795F` (`factura_id`);

--
-- Indices de la tabla `formapago`
--
ALTER TABLE `formapago`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `guia`
--
ALTER TABLE `guia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_FB379403DE734E51` (`cliente_id`),
  ADD KEY `IDX_FB3794036BDF87DF` (`emisor_id`),
  ADD KEY `IDX_FB37940371B61351` (`establecimiento_id`),
  ADD KEY `IDX_FB379403E01B1B5E` (`ptoEmision_id`),
  ADD KEY `IDX_FB3794033174800F` (`createdBy_id`),
  ADD KEY `IDX_FB37940365FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_FB37940363D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `guiahasproducto`
--
ALTER TABLE `guiahasproducto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_721B89A77645698E` (`producto_id`),
  ADD KEY `IDX_721B89A762AA81F` (`guia_id`);

--
-- Indices de la tabla `impuesto`
--
ALTER TABLE `impuesto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_4F9058F7CE7FF8C7` (`facturaHasProducto_id`),
  ADD KEY `IDX_4F9058F798D062E6` (`notaCreditoHasProducto_id`),
  ADD KEY `IDX_4F9058F7FC96FD8` (`notaDebito_id`);

--
-- Indices de la tabla `impuestocomprobanteretencion`
--
ALTER TABLE `impuestocomprobanteretencion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_86AD65C722EC49A` (`retencion_id`);

--
-- Indices de la tabla `impuestoice`
--
ALTER TABLE `impuestoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6F0EE7863174800F` (`createdBy_id`),
  ADD KEY `IDX_6F0EE78665FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_6F0EE78663D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `impuestoirbpnr`
--
ALTER TABLE `impuestoirbpnr`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_AB0A0C0B3174800F` (`createdBy_id`),
  ADD KEY `IDX_AB0A0C0B65FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_AB0A0C0B63D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `impuestoiva`
--
ALTER TABLE `impuestoiva`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_5FD6C58B3174800F` (`createdBy_id`),
  ADD KEY `IDX_5FD6C58B65FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_5FD6C58B63D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_54DE249DBF127A8F` (`Factura_id`),
  ADD KEY `IDX_54DE249D51CA559D` (`NotaCredito_id`),
  ADD KEY `IDX_54DE249DBCB7242D` (`NotaDebito_id`),
  ADD KEY `IDX_54DE249D6A1F1F62` (`Retencion_id`),
  ADD KEY `IDX_54DE249DC9979183` (`Guia_id`);

--
-- Indices de la tabla `motivo`
--
ALTER TABLE `motivo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1E553D50359609FE` (`dotaDebito_id`);

--
-- Indices de la tabla `notacredito`
--
ALTER TABLE `notacredito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_799C85D7DE734E51` (`cliente_id`),
  ADD KEY `IDX_799C85D76BDF87DF` (`emisor_id`),
  ADD KEY `IDX_799C85D771B61351` (`establecimiento_id`),
  ADD KEY `IDX_799C85D7E01B1B5E` (`ptoEmision_id`),
  ADD KEY `IDX_799C85D73174800F` (`createdBy_id`),
  ADD KEY `IDX_799C85D765FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_799C85D763D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `notacreditohasproducto`
--
ALTER TABLE `notacreditohasproducto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_721E66DE7645698E` (`producto_id`),
  ADD KEY `IDX_721E66DE9CAE2D45` (`notaCredito_id`);

--
-- Indices de la tabla `notadebito`
--
ALTER TABLE `notadebito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_60947670DE734E51` (`cliente_id`),
  ADD KEY `IDX_609476706BDF87DF` (`emisor_id`),
  ADD KEY `IDX_6094767071B61351` (`establecimiento_id`),
  ADD KEY `IDX_60947670E01B1B5E` (`ptoEmision_id`),
  ADD KEY `IDX_609476703174800F` (`createdBy_id`),
  ADD KEY `IDX_6094767065FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_6094767063D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `plan`
--
ALTER TABLE `plan`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_5ECD64436BDF87DF` (`emisor_id`),
  ADD KEY `IDX_5ECD6443D0B25EB1` (`impuesto_iva_id`),
  ADD KEY `IDX_5ECD6443F7D0D114` (`impuesto_ice_id`),
  ADD KEY `IDX_5ECD64432780846A` (`impuesto_irbpnr_id`),
  ADD KEY `IDX_5ECD64433174800F` (`createdBy_id`),
  ADD KEY `IDX_5ECD644365FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_5ECD644363D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `ptoemision`
--
ALTER TABLE `ptoemision`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_BE82597CA76ED395` (`user_id`),
  ADD KEY `IDX_BE82597C71B61351` (`establecimiento_id`),
  ADD KEY `IDX_BE82597C3174800F` (`createdBy_id`),
  ADD KEY `IDX_BE82597C65FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_BE82597C63D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `retencion`
--
ALTER TABLE `retencion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6240E309DE734E51` (`cliente_id`),
  ADD KEY `IDX_6240E3096BDF87DF` (`emisor_id`),
  ADD KEY `IDX_6240E30971B61351` (`establecimiento_id`),
  ADD KEY `IDX_6240E309E01B1B5E` (`ptoEmision_id`),
  ADD KEY `IDX_6240E3093174800F` (`createdBy_id`),
  ADD KEY `IDX_6240E30965FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_6240E30963D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F75B25543174800F` (`createdBy_id`),
  ADD KEY `IDX_F75B255465FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_F75B255463D8C20E` (`deletedBy_id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_2DA179776BDF87DF` (`emisor_id`),
  ADD KEY `IDX_2DA179774BAB96C` (`rol_id`),
  ADD KEY `IDX_2DA179773174800F` (`createdBy_id`),
  ADD KEY `IDX_2DA1797765FF1AEC` (`updatedBy_id`),
  ADD KEY `IDX_2DA1797763D8C20E` (`deletedBy_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `campoadicional`
--
ALTER TABLE `campoadicional`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `cuentaporcobrar`
--
ALTER TABLE `cuentaporcobrar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalleadicional`
--
ALTER TABLE `detalleadicional`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `emisor`
--
ALTER TABLE `emisor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `establecimiento`
--
ALTER TABLE `establecimiento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `facturahasproducto`
--
ALTER TABLE `facturahasproducto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `formapago`
--
ALTER TABLE `formapago`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `guia`
--
ALTER TABLE `guia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `guiahasproducto`
--
ALTER TABLE `guiahasproducto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `impuesto`
--
ALTER TABLE `impuesto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT de la tabla `impuestocomprobanteretencion`
--
ALTER TABLE `impuestocomprobanteretencion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `impuestoice`
--
ALTER TABLE `impuestoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `impuestoirbpnr`
--
ALTER TABLE `impuestoirbpnr`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `impuestoiva`
--
ALTER TABLE `impuestoiva`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `motivo`
--
ALTER TABLE `motivo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notacredito`
--
ALTER TABLE `notacredito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notacreditohasproducto`
--
ALTER TABLE `notacreditohasproducto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notadebito`
--
ALTER TABLE `notadebito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plan`
--
ALTER TABLE `plan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `ptoemision`
--
ALTER TABLE `ptoemision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `retencion`
--
ALTER TABLE `retencion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `campoadicional`
--
ALTER TABLE `campoadicional`
  ADD CONSTRAINT `FK_D7FF66CF51CA559D` FOREIGN KEY (`NotaCredito_id`) REFERENCES `notacredito` (`id`),
  ADD CONSTRAINT `FK_D7FF66CF6A1F1F62` FOREIGN KEY (`Retencion_id`) REFERENCES `retencion` (`id`),
  ADD CONSTRAINT `FK_D7FF66CFBCB7242D` FOREIGN KEY (`NotaDebito_id`) REFERENCES `notadebito` (`id`),
  ADD CONSTRAINT `FK_D7FF66CFBF127A8F` FOREIGN KEY (`Factura_id`) REFERENCES `factura` (`id`),
  ADD CONSTRAINT `FK_D7FF66CFC9979183` FOREIGN KEY (`Guia_id`) REFERENCES `guia` (`id`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `FK_3BA1A2B93174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_3BA1A2B963D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_3BA1A2B965FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_3BA1A2B96BDF87DF` FOREIGN KEY (`emisor_id`) REFERENCES `emisor` (`id`);

--
-- Filtros para la tabla `cuentaporcobrar`
--
ALTER TABLE `cuentaporcobrar`
  ADD CONSTRAINT `cuentaporcobrar_ibfk_1` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`),
  ADD CONSTRAINT `cuentaporcobrar_ibfk_2` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`);

--
-- Filtros para la tabla `detalleadicional`
--
ALTER TABLE `detalleadicional`
  ADD CONSTRAINT `FK_8779719698D062E6` FOREIGN KEY (`notaCreditoHasProducto_id`) REFERENCES `notacreditohasproducto` (`id`),
  ADD CONSTRAINT `FK_87797196CE7FF8C7` FOREIGN KEY (`facturaHasProducto_id`) REFERENCES `facturahasproducto` (`id`);

--
-- Filtros para la tabla `emisor`
--
ALTER TABLE `emisor`
  ADD CONSTRAINT `FK_C30280783174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_C302807863D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_C302807865FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_C3028078E899029B` FOREIGN KEY (`plan_id`) REFERENCES `plan` (`id`);

--
-- Filtros para la tabla `establecimiento`
--
ALTER TABLE `establecimiento`
  ADD CONSTRAINT `FK_1C61EFE03174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_1C61EFE063D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_1C61EFE065FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_1C61EFE06BDF87DF` FOREIGN KEY (`emisor_id`) REFERENCES `emisor` (`id`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `FK_365699953174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_3656999563D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_3656999565FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_365699956BDF87DF` FOREIGN KEY (`emisor_id`) REFERENCES `emisor` (`id`),
  ADD CONSTRAINT `FK_3656999571B61351` FOREIGN KEY (`establecimiento_id`) REFERENCES `establecimiento` (`id`),
  ADD CONSTRAINT `FK_36569995DE734E51` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `FK_36569995E01B1B5E` FOREIGN KEY (`ptoEmision_id`) REFERENCES `ptoemision` (`id`);

--
-- Filtros para la tabla `facturahasproducto`
--
ALTER TABLE `facturahasproducto`
  ADD CONSTRAINT `FK_1CFCFE017645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `FK_1CFCFE01F04F795F` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`);

--
-- Filtros para la tabla `guia`
--
ALTER TABLE `guia`
  ADD CONSTRAINT `FK_FB3794033174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_FB37940363D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_FB37940365FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_FB3794036BDF87DF` FOREIGN KEY (`emisor_id`) REFERENCES `emisor` (`id`),
  ADD CONSTRAINT `FK_FB37940371B61351` FOREIGN KEY (`establecimiento_id`) REFERENCES `establecimiento` (`id`),
  ADD CONSTRAINT `FK_FB379403DE734E51` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `FK_FB379403E01B1B5E` FOREIGN KEY (`ptoEmision_id`) REFERENCES `ptoemision` (`id`);

--
-- Filtros para la tabla `guiahasproducto`
--
ALTER TABLE `guiahasproducto`
  ADD CONSTRAINT `FK_721B89A762AA81F` FOREIGN KEY (`guia_id`) REFERENCES `guia` (`id`),
  ADD CONSTRAINT `FK_721B89A77645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`);

--
-- Filtros para la tabla `impuesto`
--
ALTER TABLE `impuesto`
  ADD CONSTRAINT `FK_4F9058F798D062E6` FOREIGN KEY (`notaCreditoHasProducto_id`) REFERENCES `notacreditohasproducto` (`id`),
  ADD CONSTRAINT `FK_4F9058F7CE7FF8C7` FOREIGN KEY (`facturaHasProducto_id`) REFERENCES `facturahasproducto` (`id`),
  ADD CONSTRAINT `FK_4F9058F7FC96FD8` FOREIGN KEY (`notaDebito_id`) REFERENCES `notadebito` (`id`);

--
-- Filtros para la tabla `impuestocomprobanteretencion`
--
ALTER TABLE `impuestocomprobanteretencion`
  ADD CONSTRAINT `FK_86AD65C722EC49A` FOREIGN KEY (`retencion_id`) REFERENCES `retencion` (`id`);

--
-- Filtros para la tabla `impuestoice`
--
ALTER TABLE `impuestoice`
  ADD CONSTRAINT `FK_6F0EE7863174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_6F0EE78663D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_6F0EE78665FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `impuestoirbpnr`
--
ALTER TABLE `impuestoirbpnr`
  ADD CONSTRAINT `FK_AB0A0C0B3174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_AB0A0C0B63D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_AB0A0C0B65FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `impuestoiva`
--
ALTER TABLE `impuestoiva`
  ADD CONSTRAINT `FK_5FD6C58B3174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_5FD6C58B63D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_5FD6C58B65FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD CONSTRAINT `FK_54DE249D51CA559D` FOREIGN KEY (`NotaCredito_id`) REFERENCES `notacredito` (`id`),
  ADD CONSTRAINT `FK_54DE249D6A1F1F62` FOREIGN KEY (`Retencion_id`) REFERENCES `retencion` (`id`),
  ADD CONSTRAINT `FK_54DE249DBCB7242D` FOREIGN KEY (`NotaDebito_id`) REFERENCES `notadebito` (`id`),
  ADD CONSTRAINT `FK_54DE249DBF127A8F` FOREIGN KEY (`Factura_id`) REFERENCES `factura` (`id`),
  ADD CONSTRAINT `FK_54DE249DC9979183` FOREIGN KEY (`Guia_id`) REFERENCES `guia` (`id`);

--
-- Filtros para la tabla `motivo`
--
ALTER TABLE `motivo`
  ADD CONSTRAINT `FK_1E553D50359609FE` FOREIGN KEY (`dotaDebito_id`) REFERENCES `notadebito` (`id`);

--
-- Filtros para la tabla `notacredito`
--
ALTER TABLE `notacredito`
  ADD CONSTRAINT `FK_799C85D73174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_799C85D763D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_799C85D765FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_799C85D76BDF87DF` FOREIGN KEY (`emisor_id`) REFERENCES `emisor` (`id`),
  ADD CONSTRAINT `FK_799C85D771B61351` FOREIGN KEY (`establecimiento_id`) REFERENCES `establecimiento` (`id`),
  ADD CONSTRAINT `FK_799C85D7DE734E51` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `FK_799C85D7E01B1B5E` FOREIGN KEY (`ptoEmision_id`) REFERENCES `ptoemision` (`id`);

--
-- Filtros para la tabla `notacreditohasproducto`
--
ALTER TABLE `notacreditohasproducto`
  ADD CONSTRAINT `FK_721E66DE7645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `FK_721E66DE9CAE2D45` FOREIGN KEY (`notaCredito_id`) REFERENCES `notacredito` (`id`);

--
-- Filtros para la tabla `notadebito`
--
ALTER TABLE `notadebito`
  ADD CONSTRAINT `FK_609476703174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_6094767063D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_6094767065FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_609476706BDF87DF` FOREIGN KEY (`emisor_id`) REFERENCES `emisor` (`id`),
  ADD CONSTRAINT `FK_6094767071B61351` FOREIGN KEY (`establecimiento_id`) REFERENCES `establecimiento` (`id`),
  ADD CONSTRAINT `FK_60947670DE734E51` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `FK_60947670E01B1B5E` FOREIGN KEY (`ptoEmision_id`) REFERENCES `ptoemision` (`id`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `FK_5ECD64432780846A` FOREIGN KEY (`impuesto_irbpnr_id`) REFERENCES `impuestoirbpnr` (`id`),
  ADD CONSTRAINT `FK_5ECD64433174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_5ECD644363D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_5ECD644365FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_5ECD64436BDF87DF` FOREIGN KEY (`emisor_id`) REFERENCES `emisor` (`id`),
  ADD CONSTRAINT `FK_5ECD6443D0B25EB1` FOREIGN KEY (`impuesto_iva_id`) REFERENCES `impuestoiva` (`id`),
  ADD CONSTRAINT `FK_5ECD6443F7D0D114` FOREIGN KEY (`impuesto_ice_id`) REFERENCES `impuestoice` (`id`);

--
-- Filtros para la tabla `ptoemision`
--
ALTER TABLE `ptoemision`
  ADD CONSTRAINT `FK_BE82597C3174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BE82597C63D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BE82597C65FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BE82597C71B61351` FOREIGN KEY (`establecimiento_id`) REFERENCES `establecimiento` (`id`),
  ADD CONSTRAINT `FK_BE82597CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `retencion`
--
ALTER TABLE `retencion`
  ADD CONSTRAINT `FK_6240E3093174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_6240E30963D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_6240E30965FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_6240E3096BDF87DF` FOREIGN KEY (`emisor_id`) REFERENCES `emisor` (`id`),
  ADD CONSTRAINT `FK_6240E30971B61351` FOREIGN KEY (`establecimiento_id`) REFERENCES `establecimiento` (`id`),
  ADD CONSTRAINT `FK_6240E309DE734E51` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `FK_6240E309E01B1B5E` FOREIGN KEY (`ptoEmision_id`) REFERENCES `ptoemision` (`id`);

--
-- Filtros para la tabla `role`
--
ALTER TABLE `role`
  ADD CONSTRAINT `FK_F75B25543174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_F75B255463D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_F75B255465FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_2DA179773174800F` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_2DA179774BAB96C` FOREIGN KEY (`rol_id`) REFERENCES `role` (`id`),
  ADD CONSTRAINT `FK_2DA1797763D8C20E` FOREIGN KEY (`deletedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_2DA1797765FF1AEC` FOREIGN KEY (`updatedBy_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_2DA179776BDF87DF` FOREIGN KEY (`emisor_id`) REFERENCES `emisor` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
