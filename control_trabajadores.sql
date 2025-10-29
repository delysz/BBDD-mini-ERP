-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-10-2025 a las 18:34:33
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
-- Base de datos: `control_trabajadores`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `id_tarea` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `empresa` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `id_tarea`, `nombre`, `empresa`, `telefono`, `email`, `direccion`) VALUES
(1, 1, 'Juan López', 'SegurTech S.L.', '600555666', 'juan@segurtech.com', 'C/ Valencia 30'),
(2, 2, 'María Torres', 'RedesPro', '600777888', 'maria@redespro.com', 'Av. Castilla 15'),
(3, 3, 'Pedro Díaz', 'DataSafe', '600999000', 'pedro@datasafe.com', 'C/ Toledo 8');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int(11) NOT NULL,
  `id_tarea` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `numero_factura` varchar(50) NOT NULL,
  `fecha_emision` date DEFAULT curdate(),
  `fecha_vencimiento` date DEFAULT NULL,
  `base_imponible` decimal(10,2) NOT NULL,
  `iva_porcentaje` decimal(4,2) DEFAULT 21.00,
  `total_factura` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','pagada','anulada') DEFAULT 'pendiente',
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fichajes`
--

CREATE TABLE `fichajes` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_hora` datetime DEFAULT current_timestamp(),
  `tipo` enum('entrada','salida') DEFAULT 'entrada',
  `ubicacion` varchar(100) DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  `fecha` date DEFAULT curdate(),
  `hora_entrada` time DEFAULT NULL,
  `hora_salida` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `fichajes`
--

INSERT INTO `fichajes` (`id`, `id_usuario`, `fecha_hora`, `tipo`, `ubicacion`, `observaciones`, `fecha`, `hora_entrada`, `hora_salida`) VALUES
(1, 3, '2025-10-27 19:07:35', 'entrada', 'Oficina Central', 'Inicio de jornada', '2025-10-29', NULL, NULL),
(2, 3, '2025-10-27 19:07:35', 'salida', 'Cliente SegurTech', 'Fin de instalación', '2025-10-29', NULL, NULL),
(3, 4, '2025-10-27 19:07:35', 'entrada', 'Cliente RedesPro', 'Inicio de mantenimiento', '2025-10-29', NULL, NULL),
(4, 4, '2025-10-27 19:07:35', '', 'Cliente RedesPro', 'Descanso', '2025-10-29', NULL, NULL),
(5, 4, '2025-10-27 19:07:35', '', 'Cliente RedesPro', 'Fin descanso', '2025-10-29', NULL, NULL),
(6, 4, '2025-10-27 19:07:35', 'salida', 'Cliente RedesPro', 'Fin de jornada', '2025-10-29', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incidencias`
--

CREATE TABLE `incidencias` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` enum('abierta','en_progreso','resuelta','cerrada') DEFAULT 'abierta',
  `prioridad` enum('baja','media','alta') DEFAULT 'media',
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_resolucion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `incidencias`
--

INSERT INTO `incidencias` (`id`, `id_usuario`, `categoria`, `descripcion`, `estado`, `prioridad`, `fecha_creacion`, `fecha_resolucion`) VALUES
(1, 3, 'Hardware', 'Fallo en cámara IP durante instalación', 'resuelta', 'alta', '2025-10-27 19:07:35', '2025-10-29 02:36:19'),
(2, 4, 'Software', 'Error al conectar con servidor remoto', 'en_progreso', 'media', '2025-10-27 19:07:35', NULL),
(3, 2, 'Comunicación', 'Retraso en entrega de materiales', 'resuelta', 'baja', '2025-10-27 19:07:35', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Administrador', 'Gestión completa del sistema'),
(2, 'Supervisor', 'Control de tareas e incidencias'),
(3, 'Trabajador', 'Realiza tareas y registra fichajes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `prioridad` enum('baja','media','alta') DEFAULT 'media',
  `estado` enum('pendiente','en_progreso','completada','cancelada') DEFAULT 'pendiente',
  `fecha_asignacion` datetime DEFAULT current_timestamp(),
  `fecha_limite` datetime DEFAULT NULL,
  `hora_inicio` time NOT NULL DEFAULT current_timestamp(),
  `fecha_finalizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id`, `id_usuario`, `titulo`, `descripcion`, `prioridad`, `estado`, `fecha_asignacion`, `fecha_limite`, `hora_inicio`, `fecha_finalizacion`) VALUES
(1, 3, 'Instalación de cámaras', 'Instalar sistema de videovigilancia en cliente A', 'alta', 'en_progreso', '2025-10-27 19:07:35', '2025-10-30 19:07:35', '18:23:15', NULL),
(2, 4, 'Mantenimiento de red', 'Revisar puntos de acceso y routers en cliente B', 'media', 'pendiente', '2025-10-27 19:07:35', '2025-11-01 19:07:35', '18:23:15', NULL),
(3, 3, 'Configuración de servidor', 'Actualizar y asegurar servidor Linux', 'alta', 'pendiente', '2025-10-27 19:07:35', '2025-10-29 19:07:35', '18:23:15', NULL),
(6, 3, 'JARL COndemor', '', 'alta', 'completada', '2025-10-29 02:19:55', '2025-11-06 02:19:00', '02:19:55', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `salario` decimal(10,2) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `id_rol`, `nombre`, `apellido`, `dni`, `email`, `telefono`, `direccion`, `fecha_ingreso`, `activo`, `salario`, `password_hash`, `last_login`, `foto_perfil`) VALUES
(1, 1, 'Carlos', 'Martínez', '12345678A', 'carlos@empresa.com', '600111222', 'Calle Mayor 10', '2022-01-10', 1, 2500.00, '$2y$10$/duavtm9FN4/hcNshR2icuv5usIJaxOo08aXWtGBopGQ0O/PMXcB6', '2025-10-29 15:40:21', '/APIG5/public/assets/fotos_perfil/usuario_1_1761703581.png'),
(2, 2, 'Ana', 'Pérez', '23456789B', 'ana@empresa.com', '600222333', 'Av. Libertad 45', '2023-03-05', 1, 2000.00, '$2y$10$kKuUR9r1HMDfaEPDTHhxcOiIjcjktTJvgOcKVL9c2m6/NC6WqDdYq', NULL, NULL),
(3, 3, 'Luis', 'Gómez', '34567890C', 'luis@empresa.com', '600333444', 'Calle Sol 22', '2023-09-12', 1, 1600.00, '$2y$10$Ew1hZLt4ZTXMHn7fj5tw0O5QzM3h8AqjlAWWg8Ip0iUYioqjDFrYW', NULL, NULL),
(4, 3, 'Marta', 'Ruiz', '45678901D', 'marta@empresa.com', '600444555', 'Calle Luna 14', '2024-02-20', 1, 1550.00, '$2y$10$E7SoPhCJK5Tragk9fblIpuoneccFLIznYPyZrSBtQpXZgjJOy/QW2', NULL, NULL),
(5, 3, 'Alberto', 'Royo', NULL, 'alberto@empresa.com', NULL, NULL, '2025-10-29', 1, 333.00, '$2y$10$ixVPR/jAxl1r4dY6hQSuMOs2pxu7fm1fB.ocd10U8GuE2MFPFzW3y', NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tarea` (`id_tarea`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_factura` (`numero_factura`),
  ADD KEY `id_tarea` (`id_tarea`);

--
-- Indices de la tabla `fichajes`
--
ALTER TABLE `fichajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `incidencias`
--
ALTER TABLE `incidencias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `ux_usuarios_dni` (`dni`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `idx_usuarios_email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `fichajes`
--
ALTER TABLE `fichajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `incidencias`
--
ALTER TABLE `incidencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`id_tarea`) REFERENCES `tareas` (`id`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`id_tarea`) REFERENCES `tareas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `fichajes`
--
ALTER TABLE `fichajes`
  ADD CONSTRAINT `fichajes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `incidencias`
--
ALTER TABLE `incidencias`
  ADD CONSTRAINT `incidencias_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
