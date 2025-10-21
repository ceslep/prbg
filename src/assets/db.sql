-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 21-10-2025 a las 08:22:55
-- Versión del servidor: 5.7.23-23
-- Versión de PHP: 8.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de datos: `iedeocci_occidente`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accesos_especiales`
--

CREATE TABLE `accesos_especiales` (
  `ind` bigint(20) NOT NULL,
  `docente` bigint(20) NOT NULL,
  `asignaturas` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actualizacion`
--

CREATE TABLE `actualizacion` (
  `ind` bigint(3) NOT NULL,
  `disponible` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `fechaInicial` date NOT NULL,
  `fechaFinal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acudientesTTTT`
--

CREATE TABLE `acudientesTTTT` (
  `ind` int(5) NOT NULL,
  `estudiante` varchar(20) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `acudiente` varchar(42) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `telefono1` varchar(23) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `telefono2` varchar(20) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areasCINCO`
--

CREATE TABLE `areasCINCO` (
  `estudiante` bigint(20) NOT NULL,
  `nombres` varchar(38) CHARACTER SET utf8 DEFAULT NULL,
  `area` varchar(31) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `asignat` varchar(10) CHARACTER SET utf8 NOT NULL,
  `valoracion` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areasFinal`
--

CREATE TABLE `areasFinal` (
  `estudiante` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `nombres` varchar(38) CHARACTER SET utf8 DEFAULT NULL,
  `area` varchar(31) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `asignat` varchar(10) CHARACTER SET utf8 NOT NULL,
  `valoracion` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `areastotales`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `areastotales` (
`estudiante` bigint(20)
,`grado` varchar(4)
,`nombres` varchar(38)
,`sede` varchar(100)
,`area` varchar(31)
,`asignatura` varchar(50)
,`valoracion` double
,`nivel` int(11)
,`numero` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion_asignaturas`
--

CREATE TABLE `asignacion_asignaturas` (
  `ind` bigint(20) NOT NULL,
  `docente` bigint(20) DEFAULT NULL,
  `sede` int(1) NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `grados` varchar(3) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nivel` int(2) NOT NULL,
  `numero` int(2) NOT NULL,
  `abreviatura` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `materia` varchar(12) COLLATE utf8_spanish2_ci NOT NULL,
  `codigo` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `banda` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `visible` varchar(1) CHARACTER SET utf32 COLLATE utf32_spanish2_ci NOT NULL DEFAULT 'S',
  `orden` double NOT NULL,
  `year` int(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion_asignaturas_old`
--

CREATE TABLE `asignacion_asignaturas_old` (
  `ind` bigint(20) NOT NULL,
  `docente` bigint(20) DEFAULT NULL,
  `sede` int(1) NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `grados` varchar(3) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nivel` int(2) NOT NULL,
  `numero` int(2) NOT NULL,
  `abreviatura` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `materia` varchar(12) COLLATE utf8_spanish2_ci NOT NULL,
  `codigo` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `banda` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `visible` varchar(1) CHARACTER SET utf32 COLLATE utf32_spanish2_ci NOT NULL DEFAULT 'S',
  `orden` double NOT NULL,
  `year` int(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspectosIndividuales`
--

CREATE TABLE `aspectosIndividuales` (
  `ind` bigint(20) NOT NULL,
  `docente` bigint(20) NOT NULL,
  `grado` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `periodo` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `aspecto` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `porcentaje` decimal(4,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `nota` int(2) NOT NULL,
  `year` int(4) NOT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `cantidades`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `cantidades` (
`estudiante` bigint(20)
,`nombres` varchar(38)
,`grado` varchar(4)
,`sede` varchar(100)
,`periodo` varchar(12)
,`cantidad` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `cantidadesNulas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `cantidadesNulas` (
`grado` varchar(4)
,`sede` varchar(100)
,`periodo` varchar(12)
,`moda` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigos`
--

CREATE TABLE `codigos` (
  `ind` int(6) NOT NULL,
  `codigo` int(5) DEFAULT NULL,
  `estudiante` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `consolidado_inasistencias_2023`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `consolidado_inasistencias_2023` (
`estudiante` bigint(20)
,`nombres` varchar(38)
,`grupo` varchar(23)
,`sede` varchar(100)
,`materia` varchar(50)
,`total` double
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `Consulta odontologia`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `Consulta odontologia` (
`nombres` varchar(38)
,`estudiante` bigint(20)
,`eps` varchar(50)
,`direccion` varchar(300)
,`telefono1` varchar(20)
,`telefono2` varchar(20)
,`activo` varchar(1)
,`asignacion_descripcion` varchar(21)
,`nivel` int(2)
,`numero` int(2)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `convivencia`
--

CREATE TABLE `convivencia` (
  `ind` bigint(20) NOT NULL,
  `estudiante` bigint(20) NOT NULL,
  `docente` bigint(20) NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `tipoFalta` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `faltas` longtext COLLATE utf8_spanish2_ci NOT NULL,
  `hora` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `fecha` date NOT NULL,
  `descripcionSituacion` longtext COLLATE utf8_spanish2_ci NOT NULL,
  `descargosEstudiante` longtext COLLATE utf8_spanish2_ci NOT NULL,
  `positivos` longtext COLLATE utf8_spanish2_ci NOT NULL,
  `firma` longtext COLLATE utf8_spanish2_ci NOT NULL,
  `firmaAcudiente` longtext COLLATE utf8_spanish2_ci NOT NULL,
  `device` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desempenos`
--

CREATE TABLE `desempenos` (
  `ind` bigint(20) NOT NULL,
  `grado` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `asignatura` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `docente` bigint(20) NOT NULL,
  `periodo` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `desempeno` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `descripcionEspecial` varchar(300) COLLATE utf8_spanish2_ci NOT NULL,
  `updatedat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desempenos2`
--

CREATE TABLE `desempenos2` (
  `ind` bigint(20) NOT NULL DEFAULT '0',
  `grado` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `asignatura` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `docente` bigint(20) NOT NULL,
  `periodo` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `desempeno` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `descripcionEspecial` varchar(300) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `updatedat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desempenos3`
--

CREATE TABLE `desempenos3` (
  `ind` bigint(20) NOT NULL DEFAULT '0',
  `grado` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `asignatura` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `docente` bigint(20) NOT NULL,
  `periodo` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `desempeno` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `descripcionEspecial` varchar(300) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `updatedat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docentes`
--

CREATE TABLE `docentes` (
  `identificacion` bigint(20) DEFAULT NULL,
  `nombres` varchar(80) CHARACTER SET utf8 DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `asignacion` varchar(15) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `activo` varchar(1) CHARACTER SET utf8 DEFAULT NULL,
  `pass` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `codigoTemporal` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `solocitaCodigo` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `verEstudiantes` varchar(1) COLLATE utf8_spanish2_ci NOT NULL DEFAULT 'N',
  `maestra` varchar(20) CHARACTER SET utf8 NOT NULL,
  `banda` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `acceso_total` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `idn` longtext COLLATE utf8_spanish2_ci NOT NULL,
  `soloexcusas` varchar(1) COLLATE utf8_spanish2_ci NOT NULL DEFAULT 'N',
  `fechaactualizacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escalas_1290`
--

CREATE TABLE `escalas_1290` (
  `ind` int(11) NOT NULL,
  `valoracion` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `inicio` double NOT NULL,
  `fin` double NOT NULL,
  `abreviatura` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadoNotas`
--

CREATE TABLE `estadoNotas` (
  `ind` int(1) NOT NULL,
  `estado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `estudiantesactivos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `estudiantesactivos` (
`estudiante` bigint(20)
,`nombres` varchar(38)
,`nivel` int(2)
,`numero` int(2)
,`asignacion` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `estugrps`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `estugrps` (
`estudiante` bigint(20)
,`nombres` varchar(38)
,`asignacion` int(1)
,`grupo` varchar(23)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estugrupos`
--

CREATE TABLE `estugrupos` (
  `ind` bigint(20) NOT NULL,
  `codigo` bigint(6) NOT NULL,
  `estudiante` bigint(20) NOT NULL,
  `nombres` varchar(38) CHARACTER SET utf8 DEFAULT NULL,
  `asignacion` int(1) DEFAULT NULL,
  `institucion_externa` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `genero` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `fecnac` date NOT NULL,
  `edad` int(11) NOT NULL,
  `nivel` int(2) DEFAULT NULL,
  `grado` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `numero` int(2) NOT NULL,
  `anio` int(5) NOT NULL,
  `pass` varchar(20) CHARACTER SET utf32 COLLATE utf32_spanish2_ci NOT NULL,
  `activo` varchar(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `banda` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `HED` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `idacudiente` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `acudiente` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono1` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono2` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `direccion` varchar(300) COLLATE utf8_spanish2_ci NOT NULL,
  `email_estudiante` varchar(80) COLLATE utf8_spanish2_ci NOT NULL,
  `email_acudiente` varchar(80) COLLATE utf8_spanish2_ci NOT NULL,
  `desertor` varchar(1) COLLATE utf8_spanish2_ci NOT NULL DEFAULT 'N',
  `otraInformacion` varchar(1000) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `year` int(5) NOT NULL,
  `lugar` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `sisben` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `estrato` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarNacimiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarExpedicion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `fechaExpedicion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `tdei` varchar(5) COLLATE utf8_spanish2_ci NOT NULL,
  `victimaConflicto` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarDesplazamiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `fechaDesplazamiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `etnia` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `tipoSangre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `eps` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `padre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `padreid` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `telefonopadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `ocupacionpadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `madre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `madreid` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `telefonomadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `ocupacionmadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `parentesco` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `discapacidad` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono_acudiente` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `eanterior` varchar(50) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estugrupos2`
--

CREATE TABLE `estugrupos2` (
  `ind` bigint(20) NOT NULL,
  `codigo` bigint(6) NOT NULL,
  `estudiante` bigint(20) NOT NULL,
  `nombres` varchar(38) CHARACTER SET utf8 DEFAULT NULL,
  `asignacion` int(1) DEFAULT NULL,
  `institucion_externa` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `genero` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `fecnac` date NOT NULL,
  `edad` int(11) NOT NULL,
  `nivel` int(2) DEFAULT NULL,
  `grado` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `numero` int(2) NOT NULL,
  `anio` int(5) NOT NULL,
  `pass` varchar(20) CHARACTER SET utf32 COLLATE utf32_spanish2_ci NOT NULL,
  `activo` varchar(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `banda` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `HED` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `idacudiente` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `acudiente` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono1` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono2` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `direccion` varchar(300) COLLATE utf8_spanish2_ci NOT NULL,
  `email_estudiante` varchar(80) COLLATE utf8_spanish2_ci NOT NULL,
  `email_acudiente` varchar(80) COLLATE utf8_spanish2_ci NOT NULL,
  `desertor` varchar(1) COLLATE utf8_spanish2_ci NOT NULL DEFAULT 'N',
  `otraInformacion` varchar(300) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `year` int(5) NOT NULL,
  `lugar` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `sisben` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `estrato` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarNacimiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarExpedicion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `fechaExpedicion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `tdei` varchar(5) COLLATE utf8_spanish2_ci NOT NULL,
  `victimaConflicto` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarDesplazamiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `fechaDesplazamiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `etnia` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `tipoSangre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `eps` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `padre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `padreid` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `telefonopadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `ocupacionpadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `madre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `madreid` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `telefonomadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `ocupacionmadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `parentesco` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `discapacidad` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono_acudiente` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `eanterior` varchar(50) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estugrupos3`
--

CREATE TABLE `estugrupos3` (
  `ind` bigint(20) NOT NULL,
  `codigo` bigint(6) NOT NULL,
  `estudiante` bigint(20) NOT NULL,
  `nombres` varchar(38) CHARACTER SET utf8 DEFAULT NULL,
  `asignacion` int(1) DEFAULT NULL,
  `institucion_externa` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `genero` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `fecnac` date NOT NULL,
  `edad` int(11) NOT NULL,
  `nivel` int(2) DEFAULT NULL,
  `grado` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `numero` int(2) NOT NULL,
  `anio` int(5) NOT NULL,
  `pass` varchar(20) CHARACTER SET utf32 COLLATE utf32_spanish2_ci NOT NULL,
  `activo` varchar(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `banda` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `HED` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `idacudiente` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `acudiente` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono1` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono2` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `direccion` varchar(300) COLLATE utf8_spanish2_ci NOT NULL,
  `email_estudiante` varchar(80) COLLATE utf8_spanish2_ci NOT NULL,
  `email_acudiente` varchar(80) COLLATE utf8_spanish2_ci NOT NULL,
  `desertor` varchar(1) COLLATE utf8_spanish2_ci NOT NULL DEFAULT 'N',
  `otraInformacion` varchar(300) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `year` int(5) NOT NULL,
  `lugar` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `sisben` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `estrato` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarNacimiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarExpedicion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `fechaExpedicion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `tdei` varchar(5) COLLATE utf8_spanish2_ci NOT NULL,
  `victimaConflicto` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarDesplazamiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `fechaDesplazamiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `etnia` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `tipoSangre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `eps` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `padre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `padreid` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `telefonopadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `ocupacionpadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `madre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `madreid` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `telefonomadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `ocupacionmadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `parentesco` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `discapacidad` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono_acudiente` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `eanterior` varchar(50) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estugrupos2023`
--

CREATE TABLE `estugrupos2023` (
  `ind` bigint(20) NOT NULL,
  `codigo` bigint(6) NOT NULL,
  `estudiante` bigint(20) NOT NULL,
  `nombres` varchar(38) CHARACTER SET utf8 DEFAULT NULL,
  `asignacion` int(1) DEFAULT NULL,
  `genero` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `nivel` int(2) DEFAULT NULL,
  `grado` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `numero` int(2) NOT NULL,
  `anio` int(5) NOT NULL,
  `pass` varchar(20) CHARACTER SET utf32 COLLATE utf32_spanish2_ci NOT NULL,
  `activo` varchar(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `banda` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `HED` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `acudiente` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono1` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono2` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `direccion` varchar(300) COLLATE utf8_spanish2_ci NOT NULL,
  `email_estudiante` varchar(80) COLLATE utf8_spanish2_ci NOT NULL,
  `email_acudiente` varchar(80) COLLATE utf8_spanish2_ci NOT NULL,
  `desertor` varchar(1) COLLATE utf8_spanish2_ci NOT NULL DEFAULT 'N',
  `otraInformacion` varchar(300) COLLATE utf8_spanish2_ci NOT NULL,
  `year` int(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estugruposALL`
--

CREATE TABLE `estugruposALL` (
  `ind` bigint(20) UNSIGNED NOT NULL,
  `estudiante` bigint(20) DEFAULT NULL,
  `nivel` bigint(20) DEFAULT NULL,
  `grupo` varchar(4) DEFAULT NULL,
  `anio` bigint(4) DEFAULT NULL,
  `asignacion` bigint(20) DEFAULT NULL,
  `director` varchar(20) DEFAULT NULL,
  `fecha_matricula` date DEFAULT NULL,
  `nombregrupo` varchar(50) DEFAULT NULL,
  `jornada` varchar(50) DEFAULT NULL,
  `numero` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `excusas`
--

CREATE TABLE `excusas` (
  `ind` int(6) NOT NULL,
  `estudiante` bigint(20) NOT NULL,
  `fecha` date NOT NULL,
  `causa` text COLLATE utf8_spanish2_ci NOT NULL,
  `motivo` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `periodo` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `horas` time NOT NULL,
  `motivo_permiso` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `hora_salida` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `acudiente` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `otros` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono_acudiente` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `FaltanDesempeños`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `FaltanDesempeños` (
`docente` bigint(20)
,`nombres` varchar(80)
,`asignatura` varchar(50)
,`grados` varchar(3)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fecnacs`
--

CREATE TABLE `fecnacs` (
  `codigo` int(5) DEFAULT NULL,
  `nombres` varchar(42) DEFAULT NULL,
  `identificacion` varchar(12) DEFAULT NULL,
  `fecnac` varchar(10) DEFAULT NULL,
  `acudiente` varchar(42) DEFAULT NULL,
  `telefono1` varchar(11) DEFAULT NULL,
  `telefono2` varchar(11) DEFAULT NULL,
  `estado` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `firmas_estudiantes`
--

CREATE TABLE `firmas_estudiantes` (
  `ind` bigint(20) NOT NULL,
  `estudiante` bigint(20) NOT NULL,
  `docente` int(12) NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `fecha` date NOT NULL,
  `descargos` text COLLATE utf8_spanish2_ci NOT NULL,
  `observacionDocente` text COLLATE utf8_spanish2_ci NOT NULL,
  `firma` longblob NOT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Hoja1`
--

CREATE TABLE `Hoja1` (
  `A` int(5) DEFAULT NULL,
  `B` varchar(4) DEFAULT NULL,
  `C` varchar(12) DEFAULT NULL,
  `D` int(8) DEFAULT NULL,
  `E` varchar(3) DEFAULT NULL,
  `F` varchar(8) DEFAULT NULL,
  `G` varchar(255) DEFAULT NULL,
  `H` varchar(246) DEFAULT NULL,
  `I` varchar(25) DEFAULT NULL,
  `J` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `id` bigint(20) NOT NULL,
  `docente` varchar(70) NOT NULL,
  `grado` varchar(20) NOT NULL,
  `materia` varchar(20) NOT NULL,
  `dia` varchar(20) NOT NULL,
  `hora` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inasistencia`
--

CREATE TABLE `inasistencia` (
  `ind` int(6) NOT NULL,
  `estudiante` bigint(20) NOT NULL,
  `nivel` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `asignacion` int(11) NOT NULL,
  `materia` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `periodo` varchar(12) COLLATE utf8_spanish2_ci NOT NULL,
  `fecha` date NOT NULL,
  `horas` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `excusa` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `docente` int(20) NOT NULL,
  `hora_clase` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `convivencia` text COLLATE utf8_spanish2_ci NOT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `detalle` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `device` text COLLATE utf8_spanish2_ci NOT NULL,
  `year` int(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `inasistencias_2023`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `inasistencias_2023` (
`ind` int(6)
,`estudiante` bigint(20)
,`nivel` int(11)
,`numero` int(11)
,`asignacion` int(11)
,`materia` varchar(50)
,`periodo` varchar(12)
,`fecha` date
,`horas` varchar(20)
,`excusa` varchar(100)
,`docente` int(20)
,`hora_clase` varchar(50)
,`convivencia` text
,`fechahora` timestamp
,`detalle` varchar(255)
,`year` int(5)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inast2`
--

CREATE TABLE `inast2` (
  `estudiante` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `nivel` int(2) DEFAULT NULL,
  `numero` int(2) NOT NULL,
  `asignacion` int(1) DEFAULT NULL,
  `fecha` date NOT NULL,
  `materia` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `info_establecimiento`
--

CREATE TABLE `info_establecimiento` (
  `ind` bigint(20) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `escudo` longtext COLLATE utf8_spanish2_ci NOT NULL,
  `nota_minima` decimal(4,2) NOT NULL,
  `nnotas` int(2) NOT NULL,
  `nota0` decimal(4,2) NOT NULL,
  `estado` varchar(1) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `intensidadHoraria`
--

CREATE TABLE `intensidadHoraria` (
  `ind` bigint(20) NOT NULL,
  `asignacion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `nivel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `valor` varchar(80) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `itemsConvivencia`
--

CREATE TABLE `itemsConvivencia` (
  `ind` bigint(20) NOT NULL,
  `itemConvivencia` text NOT NULL,
  `tipo` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log`
--

CREATE TABLE `log` (
  `ind` bigint(20) NOT NULL,
  `estudiante` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nombres` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `nivel` int(2) NOT NULL,
  `numero` int(2) NOT NULL,
  `movil` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `userAgent` text COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `coords` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `registerat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `ind` bigint(20) NOT NULL,
  `identificacion` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nombres` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `info` json NOT NULL,
  `infoCliente` json NOT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matricula`
--

CREATE TABLE `matricula` (
  `ind` bigint(20) UNSIGNED NOT NULL,
  `municipio` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `codigo` bigint(7) UNSIGNED ZEROFILL DEFAULT NULL,
  `nombre1` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nombre2` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `apellido1` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `apellido2` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nombres2` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `sexo` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `hemoclasificacion` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecnac` date DEFAULT NULL,
  `edad` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `lugarnacimiento` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `tdei` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `identificacion` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `zona` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `barrio` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `vereda` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `direccion` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nivel` int(50) DEFAULT NULL,
  `aula` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `jornada` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `principal` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `asignacion` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `procedencia` text COLLATE utf8_spanish2_ci,
  `padre` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `identificacion_padre` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ocupacion_padre` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `madre` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `identificacion_madre` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ocupacion_madre` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `acudiente` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `identificacion_acudiente` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ocupacion_acudiente` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `telefono_padre` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `email_padre` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `telefono_madre` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `email_madre` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `telefono_acudiente` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `email_acudiente` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `observaciones` text COLLATE utf8_spanish2_ci,
  `estado` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `distancia` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `estrato` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `rgss` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `estado_padres` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `exonerados` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `razon_exoneracion` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `otra_razon` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `otros` text COLLATE utf8_spanish2_ci,
  `valor_matricula` float DEFAULT NULL,
  `recibo` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `impreso` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cualsalud` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nombres` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `convive` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `parentesco` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `expedida` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `sisben` int(1) DEFAULT NULL,
  `conflicto` int(1) DEFAULT NULL,
  `munproviene` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `origen_institucion` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `origen` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `tipo_discapacidad` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `scapacidades` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `etnia` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `tdoc_acudiente` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `exp_acudiente` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `dir_acudiente` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nuevo` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `foto` longblob,
  `exalumno` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `grupo` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `banda` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `horas_servicio` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `descripcion_servicio` text COLLATE utf8_spanish2_ci,
  `refrigerio` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `desayuno` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `almuerzo` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `numero` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `especialidad` varchar(80) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `otra_info` varchar(80) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `municipio_desplazado` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha_desplazado` date DEFAULT NULL,
  `especial` char(1) COLLATE utf8_spanish2_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajeNotas`
--

CREATE TABLE `mensajeNotas` (
  `ind` int(11) NOT NULL,
  `mensaje` varchar(500) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `ind` int(11) NOT NULL,
  `linea1` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `linea2` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `activo` varchar(1) COLLATE utf8_spanish2_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noconcedidos`
--

CREATE TABLE `noconcedidos` (
  `ind` bigint(20) NOT NULL,
  `nombres` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `identificacion` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `pass` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `pass2` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `info` json NOT NULL,
  `infocliente` json NOT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noconcedidos2`
--

CREATE TABLE `noconcedidos2` (
  `ind` bigint(20) NOT NULL DEFAULT '0',
  `nombres` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `identificacion` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `pass` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `pass2` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `info` json NOT NULL,
  `infocliente` json NOT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nombresNiveles`
--

CREATE TABLE `nombresNiveles` (
  `ind` int(3) NOT NULL,
  `nivel` int(2) NOT NULL,
  `nombre` varchar(150) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

CREATE TABLE `notas` (
  `ind` bigint(45) NOT NULL,
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` bigint(20) DEFAULT NULL,
  `periodo` varchar(12) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text COLLATE utf8_spanish2_ci,
  `anotacion2` text COLLATE utf8_spanish2_ci,
  `anotacion3` text COLLATE utf8_spanish2_ci,
  `anotacion4` text COLLATE utf8_spanish2_ci,
  `anotacion5` text COLLATE utf8_spanish2_ci,
  `anotacion6` text COLLATE utf8_spanish2_ci,
  `anotacion7` text COLLATE utf8_spanish2_ci,
  `anotacion8` text COLLATE utf8_spanish2_ci,
  `anotacion9` text COLLATE utf8_spanish2_ci,
  `anotacion10` text COLLATE utf8_spanish2_ci,
  `anotacion11` text COLLATE utf8_spanish2_ci,
  `anotacion12` text COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(5) DEFAULT '2021'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Disparadores `notas`
--
DELIMITER $$
CREATE TRIGGER `after_update_notas` AFTER UPDATE ON `notas` FOR EACH ROW BEGIN
    INSERT INTO notas2 SELECT * FROM notas WHERE ind = OLD.ind;
   
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `antes_actualizar_notas` BEFORE INSERT ON `notas` FOR EACH ROW REPLACE INTO notas_historico (fecha,docente,asignatura,grado,year,tiempo,hora,minuto)
    VALUES (date(NEW.fechahora), NEW.docente, NEW.asignatura,NEW.grado,NEW.year,"Finaliza",hour(NEW.fechahora),minute(NEW.fechahora))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_notas_historico` BEFORE UPDATE ON `notas` FOR EACH ROW REPLACE INTO notas_historico (fecha,docente,asignatura,grado,year,tiempo,hora,minuto)
    VALUES (date(NEW.fechahora), NEW.docente, NEW.asignatura,NEW.grado,NEW.year,"Finaliza",hour(NEW.fechahora),minute(NEW.fechahora))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas2`
--

CREATE TABLE `notas2` (
  `ind` bigint(45) NOT NULL,
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` varchar(11) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `periodo` varchar(12) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text COLLATE utf8_spanish2_ci,
  `anotacion2` text COLLATE utf8_spanish2_ci,
  `anotacion3` text COLLATE utf8_spanish2_ci,
  `anotacion4` text COLLATE utf8_spanish2_ci,
  `anotacion5` text COLLATE utf8_spanish2_ci,
  `anotacion6` text COLLATE utf8_spanish2_ci,
  `anotacion7` text COLLATE utf8_spanish2_ci,
  `anotacion8` text COLLATE utf8_spanish2_ci,
  `anotacion9` text COLLATE utf8_spanish2_ci,
  `anotacion10` text COLLATE utf8_spanish2_ci,
  `anotacion11` text COLLATE utf8_spanish2_ci,
  `anotacion12` text COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas3`
--

CREATE TABLE `notas3` (
  `ind` bigint(45) NOT NULL DEFAULT '0',
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` varchar(11) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `periodo` varchar(12) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion2` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion3` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion4` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion5` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion6` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion7` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion8` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion9` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion10` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion11` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion12` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `notas2022`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `notas2022` (
`docente` bigint(20)
,`estudiante` bigint(20)
,`grado` varchar(4)
,`asignatura` varchar(50)
,`valoracion` decimal(4,1)
,`periodo` varchar(12)
,`nota1` decimal(4,2)
,`nota2` decimal(4,2)
,`nota3` decimal(4,2)
,`nota4` decimal(4,2)
,`nota5` decimal(4,2)
,`nota6` decimal(4,2)
,`nota7` decimal(4,2)
,`nota8` decimal(4,2)
,`nota9` decimal(4,2)
,`nota10` decimal(4,2)
,`nota11` decimal(4,2)
,`nota12` decimal(4,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `notas2022Full`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `notas2022Full` (
`estudiante` bigint(20)
,`nombres` varchar(38)
,`docente` varchar(80)
,`asignatura` varchar(50)
,`periodo` varchar(12)
,`valoracion` decimal(4,1)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notascopy`
--

CREATE TABLE `notascopy` (
  `ind` bigint(45) NOT NULL,
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` varchar(11) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `periodo` varchar(12) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text COLLATE utf8_spanish2_ci,
  `anotacion2` text COLLATE utf8_spanish2_ci,
  `anotacion3` text COLLATE utf8_spanish2_ci,
  `anotacion4` text COLLATE utf8_spanish2_ci,
  `anotacion5` text COLLATE utf8_spanish2_ci,
  `anotacion6` text COLLATE utf8_spanish2_ci,
  `anotacion7` text COLLATE utf8_spanish2_ci,
  `anotacion8` text COLLATE utf8_spanish2_ci,
  `anotacion9` text COLLATE utf8_spanish2_ci,
  `anotacion10` text COLLATE utf8_spanish2_ci,
  `anotacion11` text COLLATE utf8_spanish2_ci,
  `anotacion12` text COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notasTemporales`
--

CREATE TABLE `notasTemporales` (
  `ind` bigint(45) NOT NULL DEFAULT '0',
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` bigint(20) DEFAULT NULL,
  `periodo` varchar(12) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion2` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion3` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion4` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion5` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion6` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion7` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion8` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion9` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion10` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion11` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion12` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(5) DEFAULT '2021'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notasTemporales2`
--

CREATE TABLE `notasTemporales2` (
  `ind` bigint(45) NOT NULL DEFAULT '0',
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` bigint(20) DEFAULT NULL,
  `periodo` varchar(12) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion2` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion3` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion4` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion5` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion6` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion7` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion8` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion9` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion10` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion11` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion12` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(5) DEFAULT '2021'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notasttt`
--

CREATE TABLE `notasttt` (
  `ind` bigint(45) NOT NULL,
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` bigint(20) DEFAULT NULL,
  `periodo` varchar(12) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text COLLATE utf8_spanish2_ci,
  `anotacion2` text COLLATE utf8_spanish2_ci,
  `anotacion3` text COLLATE utf8_spanish2_ci,
  `anotacion4` text COLLATE utf8_spanish2_ci,
  `anotacion5` text COLLATE utf8_spanish2_ci,
  `anotacion6` text COLLATE utf8_spanish2_ci,
  `anotacion7` text COLLATE utf8_spanish2_ci,
  `anotacion8` text COLLATE utf8_spanish2_ci,
  `anotacion9` text COLLATE utf8_spanish2_ci,
  `anotacion10` text COLLATE utf8_spanish2_ci,
  `anotacion11` text COLLATE utf8_spanish2_ci,
  `anotacion12` text COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(5) DEFAULT '2021'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas_backup`
--

CREATE TABLE `notas_backup` (
  `ind` bigint(45) NOT NULL,
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` varchar(11) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `periodo` varchar(12) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text COLLATE utf8_spanish2_ci,
  `anotacion2` text COLLATE utf8_spanish2_ci,
  `anotacion3` text COLLATE utf8_spanish2_ci,
  `anotacion4` text COLLATE utf8_spanish2_ci,
  `anotacion5` text COLLATE utf8_spanish2_ci,
  `anotacion6` text COLLATE utf8_spanish2_ci,
  `anotacion7` text COLLATE utf8_spanish2_ci,
  `anotacion8` text COLLATE utf8_spanish2_ci,
  `anotacion9` text COLLATE utf8_spanish2_ci,
  `anotacion10` text COLLATE utf8_spanish2_ci,
  `anotacion11` text COLLATE utf8_spanish2_ci,
  `anotacion12` text COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas_backup2`
--

CREATE TABLE `notas_backup2` (
  `ind` bigint(45) NOT NULL DEFAULT '0',
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` varchar(11) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `periodo` varchar(12) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion2` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion3` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion4` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion5` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion6` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion7` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion8` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion9` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion10` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion11` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion12` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas_historico`
--

CREATE TABLE `notas_historico` (
  `id` int(20) NOT NULL,
  `fecha` date NOT NULL,
  `docente` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `grado` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `year` int(4) NOT NULL,
  `actualizado` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tiempo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `hora` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `minuto` varchar(20) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas_historico_docente`
--

CREATE TABLE `notas_historico_docente` (
  `ind` bigint(45) NOT NULL DEFAULT '0',
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` varchar(11) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `periodo` varchar(12) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion2` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion3` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion4` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion5` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion6` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion7` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion8` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion9` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion10` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion11` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion12` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(5) DEFAULT '2021'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `ind` bigint(20) NOT NULL,
  `bodyNotification` text COLLATE utf8_unicode_ci NOT NULL,
  `textNotification` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacionesLeidas`
--

CREATE TABLE `notificacionesLeidas` (
  `ind` bigint(20) NOT NULL,
  `notifyind` bigint(20) NOT NULL,
  `docente` bigint(20) NOT NULL,
  `leida` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'S'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_asignaturas`
--

CREATE TABLE `orden_asignaturas` (
  `ind` bigint(21) NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `materia` varchar(6) COLLATE utf8_spanish2_ci NOT NULL,
  `abreviatura` varchar(6) COLLATE utf8_spanish2_ci NOT NULL,
  `orden` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `ind` bigint(20) NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `tdei` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identificacion` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identificacion2` bigint(20) UNSIGNED DEFAULT NULL,
  `historia` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nombre1` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nombre2` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `apellido1` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `apellido2` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nombres` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sexo` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecnac` date DEFAULT NULL,
  `edad` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lugarnacimiento` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccion_residencia` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ciudad_residencia` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `barrio` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono_residencia1` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono_residencia2` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono_movil` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `beeper` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo_beeper` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ocupacion` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado_civil` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email1` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email2` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `factuadatos` date DEFAULT NULL,
  `otron` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `otrop` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entidad` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_de_usuario` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nivel_sisben` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ccontrib` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametros_informe`
--

CREATE TABLE `parametros_informe` (
  `ind` int(2) NOT NULL,
  `codigo_materia` varchar(16) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fila` int(2) DEFAULT NULL,
  `orden` double DEFAULT NULL,
  `fila_certificado` int(2) DEFAULT NULL,
  `year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametros_informe_primaria`
--

CREATE TABLE `parametros_informe_primaria` (
  `ind` bigint(20) NOT NULL,
  `codigo_materia` varchar(15) DEFAULT NULL,
  `fila` int(2) DEFAULT NULL,
  `orden` int(2) DEFAULT NULL,
  `fila_certificado` int(2) DEFAULT NULL,
  `year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametros_informe_primaria_5`
--

CREATE TABLE `parametros_informe_primaria_5` (
  `ind` bigint(20) NOT NULL,
  `codigo_materia` varchar(15) DEFAULT NULL,
  `fila` int(2) DEFAULT NULL,
  `orden` int(2) DEFAULT NULL,
  `fila_certificado` int(2) DEFAULT NULL,
  `year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `perdidasfinales`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `perdidasfinales` (
`estudiante` bigint(20)
,`nombres` varchar(38)
,`grado` varchar(4)
,`sede` varchar(100)
,`area` varchar(31)
,`valoracionFinal` double(19,2)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodos`
--

CREATE TABLE `periodos` (
  `ind` int(1) NOT NULL DEFAULT '0',
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `fechainicial` date NOT NULL,
  `fechafinal` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos_docentes`
--

CREATE TABLE `permisos_docentes` (
  `id` int(11) NOT NULL,
  `nombre_solicitante` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `cedula_solicitante` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `cargo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `fecha_inicio_ausencia` date NOT NULL,
  `fecha_fin_ausencia` date NOT NULL,
  `dias_ausencia` int(11) NOT NULL,
  `motivo` text COLLATE utf8_unicode_ci NOT NULL,
  `firma_solicitante` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `firma_coordinador` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firma_rectoria` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'pendiente',
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `porcentajes_Area`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `porcentajes_Area` (
`area` varchar(31)
,`nivel` int(2)
,`sum(porcentaje)` double
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `porcentajes_area_colegio`
--

CREATE TABLE `porcentajes_area_colegio` (
  `ind` int(4) NOT NULL,
  `asignatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `año` int(4) DEFAULT NULL,
  `area` varchar(31) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `abreviatura` varchar(10) NOT NULL,
  `porcentaje` double DEFAULT NULL,
  `nivel` int(2) DEFAULT NULL,
  `fila` int(2) DEFAULT NULL,
  `fila_certificado` int(11) NOT NULL,
  `orden` double DEFAULT NULL,
  `year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `porcentajes_area_colegio_5`
--

CREATE TABLE `porcentajes_area_colegio_5` (
  `ind` int(4) NOT NULL,
  `asignatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `año` int(4) DEFAULT NULL,
  `area` varchar(31) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `abreviatura` varchar(20) NOT NULL,
  `porcentaje` double DEFAULT NULL,
  `nivel` int(2) DEFAULT NULL,
  `fila` int(2) DEFAULT NULL,
  `fila_certificado` int(11) NOT NULL,
  `orden` int(2) DEFAULT NULL,
  `year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promover_estudiante`
--

CREATE TABLE `promover_estudiante` (
  `ind` bigint(45) NOT NULL DEFAULT '0',
  `estudiante` bigint(20) DEFAULT NULL,
  `grado` varchar(4) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `asignatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `docente` varchar(11) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `periodo` varchar(12) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valoracion` decimal(4,1) DEFAULT NULL,
  `nota1` decimal(4,2) DEFAULT NULL,
  `nota2` decimal(4,2) DEFAULT NULL,
  `nota3` decimal(4,2) DEFAULT NULL,
  `nota4` decimal(4,2) DEFAULT NULL,
  `nota5` decimal(4,2) DEFAULT NULL,
  `nota6` decimal(4,2) DEFAULT NULL,
  `nota7` decimal(4,2) DEFAULT NULL,
  `nota8` decimal(4,2) DEFAULT NULL,
  `nota9` decimal(4,2) DEFAULT NULL,
  `nota10` decimal(4,2) DEFAULT NULL,
  `nota11` decimal(4,2) DEFAULT NULL,
  `nota12` decimal(4,2) DEFAULT NULL,
  `porcentaje1` decimal(4,2) DEFAULT NULL,
  `porcentaje2` decimal(4,2) DEFAULT NULL,
  `porcentaje3` decimal(4,2) DEFAULT NULL,
  `porcentaje4` decimal(4,2) DEFAULT NULL,
  `porcentaje5` decimal(4,2) DEFAULT NULL,
  `porcentaje6` decimal(4,2) DEFAULT NULL,
  `porcentaje7` decimal(4,2) DEFAULT NULL,
  `porcentaje8` decimal(4,2) DEFAULT NULL,
  `porcentaje9` decimal(4,2) DEFAULT NULL,
  `porcentaje10` decimal(4,2) DEFAULT NULL,
  `porcentaje11` decimal(4,2) DEFAULT NULL,
  `porcentaje12` decimal(4,2) DEFAULT NULL,
  `aspecto1` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto2` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto3` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto4` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto5` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto6` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto7` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto8` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto9` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto10` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto11` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `aspecto12` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fecha1` date DEFAULT NULL,
  `fecha2` date DEFAULT NULL,
  `fecha3` date DEFAULT NULL,
  `fecha4` date DEFAULT NULL,
  `fecha5` date DEFAULT NULL,
  `fecha6` date DEFAULT NULL,
  `fecha7` date DEFAULT NULL,
  `fecha8` date DEFAULT NULL,
  `fecha9` date DEFAULT NULL,
  `fecha10` date DEFAULT NULL,
  `fecha11` date DEFAULT NULL,
  `fecha12` date DEFAULT NULL,
  `anotacion1` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion2` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion3` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion4` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion5` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion6` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion7` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion8` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion9` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion10` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion11` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `anotacion12` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci,
  `fechaa1` date DEFAULT NULL,
  `fechaa2` date DEFAULT NULL,
  `fechaa3` date DEFAULT NULL,
  `fechaa4` date DEFAULT NULL,
  `fechaa5` date DEFAULT NULL,
  `fechaa6` date DEFAULT NULL,
  `fechaa7` date DEFAULT NULL,
  `fechaa8` date DEFAULT NULL,
  `fechaa9` date DEFAULT NULL,
  `fechaa10` date DEFAULT NULL,
  `fechaa11` date DEFAULT NULL,
  `fechaa12` date DEFAULT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` int(5) DEFAULT '2021'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prueba_estugrupos`
--

CREATE TABLE `prueba_estugrupos` (
  `ind` bigint(20) NOT NULL,
  `codigo` bigint(6) NOT NULL,
  `estudiante` bigint(20) NOT NULL,
  `nombres` varchar(38) CHARACTER SET utf8 DEFAULT NULL,
  `asignacion` int(1) DEFAULT NULL,
  `institucion_externa` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `genero` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `fecnac` date NOT NULL,
  `edad` int(11) NOT NULL,
  `nivel` int(2) DEFAULT NULL,
  `grado` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `numero` int(2) NOT NULL,
  `anio` int(5) NOT NULL,
  `pass` varchar(20) CHARACTER SET utf32 COLLATE utf32_spanish2_ci NOT NULL,
  `activo` varchar(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `banda` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `HED` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `idacudiente` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `acudiente` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono1` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono2` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `direccion` varchar(300) COLLATE utf8_spanish2_ci NOT NULL,
  `email_estudiante` varchar(80) COLLATE utf8_spanish2_ci NOT NULL,
  `email_acudiente` varchar(80) COLLATE utf8_spanish2_ci NOT NULL,
  `desertor` varchar(1) COLLATE utf8_spanish2_ci NOT NULL DEFAULT 'N',
  `otraInformacion` varchar(300) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `year` int(5) NOT NULL,
  `lugar` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `sisben` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `estrato` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarNacimiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarExpedicion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `fechaExpedicion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `tdei` varchar(5) COLLATE utf8_spanish2_ci NOT NULL,
  `victimaConflicto` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `lugarDesplazamiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `fechaDesplazamiento` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `etnia` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `tipoSangre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `eps` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `padre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `padreid` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `telefonopadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `ocupacionpadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `madre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `madreid` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `telefonomadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `ocupacionmadre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `parentesco` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `discapacidad` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono_acudiente` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `eanterior` varchar(50) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puestos`
--

CREATE TABLE `puestos` (
  `estudiante` bigint(20) DEFAULT NULL,
  `nombres` varchar(38) CHARACTER SET utf8 DEFAULT NULL,
  `promedio` decimal(8,5) DEFAULT NULL,
  `grupo` varchar(23) COLLATE utf8_unicode_ci DEFAULT NULL,
  `asignacion` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puestosGrupo`
--

CREATE TABLE `puestosGrupo` (
  `estudiante` bigint(20) DEFAULT NULL,
  `nombres` varchar(38) CHARACTER SET utf8 DEFAULT NULL,
  `promedio` decimal(8,5) DEFAULT NULL,
  `grupo` varchar(23) COLLATE utf8_unicode_ci DEFAULT NULL,
  `asignacion` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reclamo`
--

CREATE TABLE `reclamo` (
  `ind` bigint(20) NOT NULL,
  `estudiante` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `profesor` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `aspecto` text COLLATE utf8_unicode_ci NOT NULL,
  `nota` double NOT NULL,
  `observacion` text COLLATE utf8_unicode_ci NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `registrados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `registrados` (
`identificacion` varchar(50)
,`nombres` varchar(150)
,`photoURL` text
,`registerat` timestamp
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrar`
--

CREATE TABLE `registrar` (
  `ind` bigint(20) NOT NULL,
  `identificacion` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `nombres` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `displayName` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `fechanacimiento` date NOT NULL,
  `phoneNumber` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `photoURL` text COLLATE utf8_unicode_ci NOT NULL,
  `genero` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `registerat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `google` varchar(1) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registroIngresos`
--

CREATE TABLE `registroIngresos` (
  `id` bigint(20) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `horaSalida` time NOT NULL,
  `nombres` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `asunto` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `identificacion` int(15) NOT NULL,
  `tipo_visitante` varchar(100) COLLATE utf32_spanish2_ci NOT NULL,
  `fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restricciones`
--

CREATE TABLE `restricciones` (
  `ind` int(3) NOT NULL,
  `docente` varchar(150) NOT NULL,
  `dia` varchar(50) NOT NULL,
  `hora` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedes`
--

CREATE TABLE `sedes` (
  `ind` int(1) NOT NULL,
  `sede` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguridad`
--

CREATE TABLE `seguridad` (
  `ind` bigint(20) NOT NULL,
  `docente` bigint(20) NOT NULL,
  `asignatura` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `info` json NOT NULL,
  `fechahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `sumaporcentajes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `sumaporcentajes` (
`estudiante` bigint(20)
,`asignatura` varchar(50)
,`grado` varchar(4)
,`porcentaje` decimal(15,2)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tdei`
--

CREATE TABLE `tdei` (
  `ind` int(1) NOT NULL,
  `nombre` varchar(29) DEFAULT NULL,
  `abreviatura` varchar(3) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `tiempoDocentes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `tiempoDocentes` (
`docente` varchar(20)
,`grado` varchar(10)
,`fecha` date
,`cantidad` bigint(21)
,`year(fecha)` bigint(20)
,`month(fecha)` bigint(20)
,`day(fecha)` bigint(20)
,`tt` bigint(20)
,`mf` bigint(20)
,`MIN` varchar(3)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `tiemposVista`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `tiemposVista` (
`docente` varchar(20)
,`horas` decimal(41,0)
,`minutos` decimal(44,0)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `ultimasNotas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `ultimasNotas` (
`asignatura` varchar(50)
,`docente` varchar(80)
,`grado` varchar(4)
,`periodo` varchar(12)
,`fechahora` timestamp
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vistanotasif`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vistanotasif` (
`fecha` date
,`docente` varchar(20)
,`asignatura` varchar(20)
,`grado` varchar(10)
,`min(n.fecha)` date
,`tiempo` varchar(20)
,`hora` varchar(20)
,`minuto` varchar(20)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `areastotales`
--
DROP TABLE IF EXISTS `areastotales`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `areastotales`  AS SELECT `notas`.`estudiante` AS `estudiante`, `notas`.`grado` AS `grado`, `estugrupos`.`nombres` AS `nombres`, `sedes`.`sede` AS `sede`, `porcentajes_area_colegio`.`area` AS `area`, `notas`.`asignatura` AS `asignatura`, ((avg(`notas`.`valoracion`) * `porcentajes_area_colegio`.`porcentaje`) / 100) AS `valoracion`, `estugrupos`.`nivel` AS `nivel`, `estugrupos`.`numero` AS `numero` FROM ((((`notas` join `estugrupos` on((`notas`.`estudiante` = `estugrupos`.`estudiante`))) join `porcentajes_area_colegio` on(((`notas`.`asignatura` = `porcentajes_area_colegio`.`asignatura`) and (`estugrupos`.`nivel` = `porcentajes_area_colegio`.`nivel`) and (`notas`.`year` = `porcentajes_area_colegio`.`year`)))) join `docentes` on((`notas`.`docente` = `docentes`.`identificacion`))) join `sedes` on((`estugrupos`.`asignacion` = `sedes`.`ind`))) WHERE ((1 = 1) AND (`docentes`.`activo` = 'S') AND (`estugrupos`.`asignacion` <> '5') AND (`estugrupos`.`activo` = 'S') AND (`notas`.`year` = year(curdate())) AND (`porcentajes_area_colegio`.`year` = year(curdate())) AND (`estugrupos`.`year` = year(curdate()))) GROUP BY `estugrupos`.`estudiante`, `porcentajes_area_colegio`.`area`, `notas`.`asignatura`union select `notas`.`estudiante` AS `estudiante`,`notas`.`grado` AS `grado`,`estugrupos`.`nombres` AS `nombres`,`sedes`.`sede` AS `sede`,`porcentajes_area_colegio_5`.`area` AS `area`,`notas`.`asignatura` AS `asignatura`,((avg(`notas`.`valoracion`) * `porcentajes_area_colegio_5`.`porcentaje`) / 100) AS `valoracion`,`estugrupos`.`nivel` AS `nivel`,`estugrupos`.`numero` AS `numero` from ((((`notas` join `estugrupos` on((`notas`.`estudiante` = `estugrupos`.`estudiante`))) join `porcentajes_area_colegio_5` on(((`notas`.`asignatura` = `porcentajes_area_colegio_5`.`asignatura`) and (`estugrupos`.`nivel` = `porcentajes_area_colegio_5`.`nivel`) and (`notas`.`year` = `porcentajes_area_colegio_5`.`year`)))) join `docentes` on((`notas`.`docente` = `docentes`.`identificacion`))) join `sedes` on((`estugrupos`.`asignacion` = `sedes`.`ind`))) where ((1 = 1) and (`docentes`.`activo` = 'S') and (`estugrupos`.`asignacion` = '5') and (`estugrupos`.`activo` = 'S') and (`estugrupos`.`nivel` < 6) and (`notas`.`year` = year(curdate())) and (`porcentajes_area_colegio_5`.`year` = year(curdate())) and (`estugrupos`.`year` = year(curdate()))) group by `estugrupos`.`estudiante`,`porcentajes_area_colegio_5`.`area`,`notas`.`asignatura` order by `sede`,`nivel`,`numero`,`nombres`,`area`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `cantidades`
--
DROP TABLE IF EXISTS `cantidades`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `cantidades`  AS SELECT `estugrupos`.`estudiante` AS `estudiante`, `estugrupos`.`nombres` AS `nombres`, `notas`.`grado` AS `grado`, `sedes`.`sede` AS `sede`, `notas`.`periodo` AS `periodo`, count(`notas`.`ind`) AS `cantidad` FROM ((`notas` join `estugrupos` on(((`estugrupos`.`estudiante` = `notas`.`estudiante`) and (`notas`.`year` = `estugrupos`.`year`)))) join `sedes` on((`estugrupos`.`asignacion` = `sedes`.`ind`))) WHERE ((`notas`.`year` = year(curdate())) AND (`estugrupos`.`activo` = 'S')) GROUP BY `notas`.`estudiante`, `notas`.`periodo` ORDER BY `estugrupos`.`asignacion` ASC, `estugrupos`.`nivel` ASC, `estugrupos`.`numero` ASC, `estugrupos`.`nombres` ASC, field(`notas`.`periodo`,'UNO','DOS','TRES','CUATRO') ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `cantidadesNulas`
--
DROP TABLE IF EXISTS `cantidadesNulas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `cantidadesNulas`  AS SELECT `cantidades`.`grado` AS `grado`, `cantidades`.`sede` AS `sede`, `cantidades`.`periodo` AS `periodo`, `cantidades`.`cantidad` AS `moda` FROM `cantidades` GROUP BY `cantidades`.`cantidad`, `cantidades`.`grado`, `cantidades`.`periodo` ORDER BY `cantidades`.`sede` ASC, `cantidades`.`grado` ASC, field(`cantidades`.`periodo`,'UNO','DOS','TRES','CUATRO') ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `consolidado_inasistencias_2023`
--
DROP TABLE IF EXISTS `consolidado_inasistencias_2023`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `consolidado_inasistencias_2023`  AS SELECT `estugrupos`.`estudiante` AS `estudiante`, `estugrupos`.`nombres` AS `nombres`, concat_ws('-',`estugrupos`.`nivel`,`estugrupos`.`numero`) AS `grupo`, `sedes`.`sede` AS `sede`, `inasistencias_2023`.`materia` AS `materia`, sum(`inasistencias_2023`.`horas`) AS `total` FROM ((`inasistencias_2023` join `estugrupos` on((`inasistencias_2023`.`estudiante` = `estugrupos`.`estudiante`))) join `sedes` on((`estugrupos`.`asignacion` = `sedes`.`ind`))) WHERE (`estugrupos`.`activo` = 'S') GROUP BY `inasistencias_2023`.`estudiante`, `inasistencias_2023`.`materia` ORDER BY `total` DESC, `sedes`.`sede` ASC, `grupo` ASC, `estugrupos`.`nombres` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `Consulta odontologia`
--
DROP TABLE IF EXISTS `Consulta odontologia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `Consulta odontologia`  AS SELECT `estugrupos`.`nombres` AS `nombres`, `estugrupos`.`estudiante` AS `estudiante`, `estugrupos`.`eps` AS `eps`, `estugrupos`.`direccion` AS `direccion`, `estugrupos`.`telefono1` AS `telefono1`, `estugrupos`.`telefono2` AS `telefono2`, `estugrupos`.`activo` AS `activo`, (case when (`estugrupos`.`asignacion` = 1) then 'Principal' when (`estugrupos`.`asignacion` = 2) then 'Antonio José de Sucre' when (`estugrupos`.`asignacion` = 3) then 'Celmira Piedrahita' when (`estugrupos`.`asignacion` = 4) then 'Cesar Agudelo' when (`estugrupos`.`asignacion` = 5) then 'San José' else 'Desconocido' end) AS `asignacion_descripcion`, `estugrupos`.`nivel` AS `nivel`, `estugrupos`.`numero` AS `numero` FROM `estugrupos` WHERE ((`estugrupos`.`anio` = '2025') AND (`estugrupos`.`activo` = 'N')) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `estudiantesactivos`
--
DROP TABLE IF EXISTS `estudiantesactivos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `estudiantesactivos`  AS SELECT `estugrupos`.`estudiante` AS `estudiante`, `estugrupos`.`nombres` AS `nombres`, `estugrupos`.`nivel` AS `nivel`, `estugrupos`.`numero` AS `numero`, `sedes`.`sede` AS `asignacion` FROM (`estugrupos` join `sedes` on((`estugrupos`.`asignacion` = `sedes`.`ind`))) WHERE ((`estugrupos`.`year` = year(curdate())) AND (`estugrupos`.`activo` = 'S')) ORDER BY `sedes`.`ind` ASC, `estugrupos`.`nivel` ASC, `estugrupos`.`numero` ASC, `estugrupos`.`nombres` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `estugrps`
--
DROP TABLE IF EXISTS `estugrps`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `estugrps`  AS SELECT `estugrupos`.`estudiante` AS `estudiante`, `estugrupos`.`nombres` AS `nombres`, `estugrupos`.`asignacion` AS `asignacion`, concat_ws('-',`estugrupos`.`nivel`,`estugrupos`.`numero`) AS `grupo` FROM `estugrupos` WHERE ((`estugrupos`.`year` = year(curdate())) AND (`estugrupos`.`activo` = 'S')) ORDER BY `estugrupos`.`asignacion` ASC, `estugrupos`.`nivel` ASC, `estugrupos`.`numero` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `FaltanDesempeños`
--
DROP TABLE IF EXISTS `FaltanDesempeños`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `FaltanDesempeños`  AS SELECT DISTINCT `asignacion_asignaturas`.`docente` AS `docente`, `docentes`.`nombres` AS `nombres`, `asignacion_asignaturas`.`asignatura` AS `asignatura`, `asignacion_asignaturas`.`grados` AS `grados` FROM ((`asignacion_asignaturas` left join `desempenos` on(((`asignacion_asignaturas`.`docente` = `desempenos`.`docente`) and (`asignacion_asignaturas`.`asignatura` = `desempenos`.`asignatura`) and (`desempenos`.`periodo` = 'CINCO')))) join `docentes` on((`asignacion_asignaturas`.`docente` = `docentes`.`identificacion`))) WHERE ((`asignacion_asignaturas`.`year` = 2024) AND isnull(`desempenos`.`docente`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `inasistencias_2023`
--
DROP TABLE IF EXISTS `inasistencias_2023`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `inasistencias_2023`  AS SELECT `inasistencia`.`ind` AS `ind`, `inasistencia`.`estudiante` AS `estudiante`, `inasistencia`.`nivel` AS `nivel`, `inasistencia`.`numero` AS `numero`, `inasistencia`.`asignacion` AS `asignacion`, `inasistencia`.`materia` AS `materia`, `inasistencia`.`periodo` AS `periodo`, `inasistencia`.`fecha` AS `fecha`, `inasistencia`.`horas` AS `horas`, `inasistencia`.`excusa` AS `excusa`, `inasistencia`.`docente` AS `docente`, `inasistencia`.`hora_clase` AS `hora_clase`, `inasistencia`.`convivencia` AS `convivencia`, `inasistencia`.`fechahora` AS `fechahora`, `inasistencia`.`detalle` AS `detalle`, `inasistencia`.`year` AS `year` FROM `inasistencia` WHERE (`inasistencia`.`year` = '2023') ;

-- --------------------------------------------------------

--
-- Estructura para la vista `notas2022`
--
DROP TABLE IF EXISTS `notas2022`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `notas2022`  AS SELECT `notas`.`docente` AS `docente`, `notas`.`estudiante` AS `estudiante`, `notas`.`grado` AS `grado`, `notas`.`asignatura` AS `asignatura`, `notas`.`valoracion` AS `valoracion`, `notas`.`periodo` AS `periodo`, `notas`.`nota1` AS `nota1`, `notas`.`nota2` AS `nota2`, `notas`.`nota3` AS `nota3`, `notas`.`nota4` AS `nota4`, `notas`.`nota5` AS `nota5`, `notas`.`nota6` AS `nota6`, `notas`.`nota7` AS `nota7`, `notas`.`nota8` AS `nota8`, `notas`.`nota9` AS `nota9`, `notas`.`nota10` AS `nota10`, `notas`.`nota11` AS `nota11`, `notas`.`nota12` AS `nota12` FROM `notas` WHERE (`notas`.`year` = 2022) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `notas2022Full`
--
DROP TABLE IF EXISTS `notas2022Full`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `notas2022Full`  AS SELECT `estugrupos`.`estudiante` AS `estudiante`, `estugrupos`.`nombres` AS `nombres`, `docentes`.`nombres` AS `docente`, `notas`.`asignatura` AS `asignatura`, `notas`.`periodo` AS `periodo`, `notas`.`valoracion` AS `valoracion` FROM ((`estugrupos` join `notas` on((`estugrupos`.`estudiante` = `notas`.`estudiante`))) join `docentes` on((`notas`.`docente` = `docentes`.`identificacion`))) WHERE ((`estugrupos`.`year` = year(curdate())) AND (`notas`.`year` = year(curdate()))) ORDER BY `estugrupos`.`asignacion` ASC, `estugrupos`.`nivel` ASC, `estugrupos`.`numero` ASC, `estugrupos`.`nombres` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `perdidasfinales`
--
DROP TABLE IF EXISTS `perdidasfinales`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `perdidasfinales`  AS SELECT `areastotales`.`estudiante` AS `estudiante`, `areastotales`.`nombres` AS `nombres`, `areastotales`.`grado` AS `grado`, `areastotales`.`sede` AS `sede`, `areastotales`.`area` AS `area`, round(sum(`areastotales`.`valoracion`),2) AS `valoracionFinal` FROM `areastotales` GROUP BY `areastotales`.`estudiante`, `areastotales`.`area` HAVING (`valoracionFinal` < 2.95) ORDER BY `areastotales`.`grado` ASC, `areastotales`.`nombres` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `porcentajes_Area`
--
DROP TABLE IF EXISTS `porcentajes_Area`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `porcentajes_Area`  AS SELECT `porcentajes_area_colegio`.`area` AS `area`, `porcentajes_area_colegio`.`nivel` AS `nivel`, sum(`porcentajes_area_colegio`.`porcentaje`) AS `sum(porcentaje)` FROM `porcentajes_area_colegio` WHERE (`porcentajes_area_colegio`.`year` = year(curdate())) GROUP BY `porcentajes_area_colegio`.`area`, `porcentajes_area_colegio`.`nivel` ORDER BY `porcentajes_area_colegio`.`nivel` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `registrados`
--
DROP TABLE IF EXISTS `registrados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `registrados`  AS SELECT `registrar`.`identificacion` AS `identificacion`, `registrar`.`nombres` AS `nombres`, `registrar`.`photoURL` AS `photoURL`, `registrar`.`registerat` AS `registerat` FROM `registrar` WHERE 1 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `sumaporcentajes`
--
DROP TABLE IF EXISTS `sumaporcentajes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `sumaporcentajes`  AS SELECT `notas`.`estudiante` AS `estudiante`, `notas`.`asignatura` AS `asignatura`, `notas`.`grado` AS `grado`, (((((((((((if(isnull(`notas`.`porcentaje1`),0,`notas`.`porcentaje1`) + if(isnull(`notas`.`porcentaje2`),0,`notas`.`porcentaje2`)) + if(isnull(`notas`.`porcentaje3`),0,`notas`.`porcentaje3`)) + if(isnull(`notas`.`porcentaje4`),0,`notas`.`porcentaje4`)) + if(isnull(`notas`.`porcentaje5`),0,`notas`.`porcentaje5`)) + if(isnull(`notas`.`porcentaje6`),0,`notas`.`porcentaje6`)) + if(isnull(`notas`.`porcentaje7`),0,`notas`.`porcentaje7`)) + if(isnull(`notas`.`porcentaje8`),0,`notas`.`porcentaje8`)) + if(isnull(`notas`.`porcentaje9`),0,`notas`.`porcentaje9`)) + if(isnull(`notas`.`porcentaje10`),0,`notas`.`porcentaje10`)) + if(isnull(`notas`.`porcentaje11`),0,`notas`.`porcentaje11`)) + if(isnull(`notas`.`porcentaje12`),0,`notas`.`porcentaje12`)) AS `porcentaje` FROM `notas` WHERE ((`notas`.`year` = year(curdate())) AND ((((((((((((if(isnull(`notas`.`porcentaje1`),0,`notas`.`porcentaje1`) + if(isnull(`notas`.`porcentaje2`),0,`notas`.`porcentaje2`)) + if(isnull(`notas`.`porcentaje3`),0,`notas`.`porcentaje3`)) + if(isnull(`notas`.`porcentaje4`),0,`notas`.`porcentaje4`)) + if(isnull(`notas`.`porcentaje5`),0,`notas`.`porcentaje5`)) + if(isnull(`notas`.`porcentaje6`),0,`notas`.`porcentaje6`)) + if(isnull(`notas`.`porcentaje7`),0,`notas`.`porcentaje7`)) + if(isnull(`notas`.`porcentaje8`),0,`notas`.`porcentaje8`)) + if(isnull(`notas`.`porcentaje9`),0,`notas`.`porcentaje9`)) + if(isnull(`notas`.`porcentaje10`),0,`notas`.`porcentaje10`)) + if(isnull(`notas`.`porcentaje11`),0,`notas`.`porcentaje11`)) + if(isnull(`notas`.`porcentaje12`),0,`notas`.`porcentaje12`)) > 0)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `tiempoDocentes`
--
DROP TABLE IF EXISTS `tiempoDocentes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `tiempoDocentes`  AS SELECT `notas_historico`.`docente` AS `docente`, `notas_historico`.`grado` AS `grado`, `notas_historico`.`fecha` AS `fecha`, count(`notas_historico`.`id`) AS `cantidad`, year(`notas_historico`.`fecha`) AS `year(fecha)`, month(`notas_historico`.`fecha`) AS `month(fecha)`, dayofmonth(`notas_historico`.`fecha`) AS `day(fecha)`, min((hour(`notas_historico`.`fecha`) * minute(`notas_historico`.`fecha`))) AS `tt`, -(to_seconds(min(`notas_historico`.`fecha`))) AS `mf`, 'MIN' AS `MIN` FROM `notas_historico` GROUP BY `notas_historico`.`docente`union select `notas_historico`.`docente` AS `docente`,`notas_historico`.`grado` AS `grado`,`notas_historico`.`fecha` AS `fecha`,count(`notas_historico`.`id`) AS `cantidad`,year(`notas_historico`.`fecha`) AS `year(fecha)`,month(`notas_historico`.`fecha`) AS `month(fecha)`,dayofmonth(`notas_historico`.`fecha`) AS `day(fecha)`,max((hour(`notas_historico`.`fecha`) * minute(`notas_historico`.`fecha`))) AS `tt`,to_seconds(max(`notas_historico`.`fecha`)) AS `mf`,'MAX' AS `MAX` from `notas_historico` group by `notas_historico`.`docente` order by `docente`,`mf`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `tiemposVista`
--
DROP TABLE IF EXISTS `tiemposVista`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `tiemposVista`  AS SELECT `tiempoDocentes`.`docente` AS `docente`, truncate((sum(`tiempoDocentes`.`mf`) / 3600),0) AS `horas`, truncate((((sum(`tiempoDocentes`.`mf`) / 3600) - truncate((sum(`tiempoDocentes`.`mf`) / 3600),0)) * 60),0) AS `minutos` FROM `tiempoDocentes` GROUP BY `tiempoDocentes`.`docente` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `ultimasNotas`
--
DROP TABLE IF EXISTS `ultimasNotas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `ultimasNotas`  AS SELECT DISTINCT `notas`.`asignatura` AS `asignatura`, `docentes`.`nombres` AS `docente`, `notas`.`grado` AS `grado`, `notas`.`periodo` AS `periodo`, `notas`.`fechahora` AS `fechahora` FROM (`notas` join `docentes` on((`notas`.`docente` = `docentes`.`identificacion`))) WHERE (`notas`.`year` = year(curdate())) ORDER BY `notas`.`fechahora` DESC LIMIT 0, 2000 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vistanotasif`
--
DROP TABLE IF EXISTS `vistanotasif`;

CREATE ALGORITHM=UNDEFINED DEFINER=`iedeocci`@`localhost` SQL SECURITY DEFINER VIEW `vistanotasif`  AS SELECT `n`.`fecha` AS `fecha`, `n`.`docente` AS `docente`, `n`.`asignatura` AS `asignatura`, `n`.`grado` AS `grado`, min(`n`.`fecha`) AS `min(n.fecha)`, `n`.`tiempo` AS `tiempo`, `n`.`hora` AS `hora`, `n`.`minuto` AS `minuto` FROM `notas_historico` AS `n` WHERE (`n`.`tiempo` = 'Inicia') GROUP BY `n`.`docente`, `n`.`asignatura`, `n`.`grado`union select `n`.`fecha` AS `fecha`,`n`.`docente` AS `docente`,`n`.`asignatura` AS `asignatura`,`n`.`grado` AS `grado`,max(`n`.`fecha`) AS `max(n.fecha)`,`n`.`tiempo` AS `tiempo`,`n`.`hora` AS `hora`,`n`.`minuto` AS `minuto` from `notas_historico` `n` where (`n`.`tiempo` = 'Finaliza') group by `n`.`docente`,`n`.`asignatura`,`n`.`grado`,`n`.`tiempo` order by `docente`,`asignatura`,`grado`,`fecha`,(case when (`tiempo` = 'inicia') then 1 when (`tiempo` = 'finaliza') then 2 end)  ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accesos_especiales`
--
ALTER TABLE `accesos_especiales`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD KEY `ind_2` (`ind`);

--
-- Indices de la tabla `actualizacion`
--
ALTER TABLE `actualizacion`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `acudientesTTTT`
--
ALTER TABLE `acudientesTTTT`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `asignacion_asignaturas`
--
ALTER TABLE `asignacion_asignaturas`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD UNIQUE KEY `sede_2` (`sede`,`asignatura`,`nivel`,`numero`,`year`),
  ADD KEY `docente` (`docente`),
  ADD KEY `docente_2` (`docente`),
  ADD KEY `ind_2` (`ind`),
  ADD KEY `asignatura` (`asignatura`),
  ADD KEY `yearind` (`ind`),
  ADD KEY `year` (`year`),
  ADD KEY `nivel` (`nivel`),
  ADD KEY `numero` (`numero`),
  ADD KEY `orden` (`orden`),
  ADD KEY `codigo` (`codigo`),
  ADD KEY `visible` (`visible`),
  ADD KEY `materia` (`materia`),
  ADD KEY `grados` (`grados`),
  ADD KEY `sede` (`sede`);

--
-- Indices de la tabla `asignacion_asignaturas_old`
--
ALTER TABLE `asignacion_asignaturas_old`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD KEY `docente` (`docente`),
  ADD KEY `docente_2` (`docente`),
  ADD KEY `ind_2` (`ind`),
  ADD KEY `asignatura` (`asignatura`),
  ADD KEY `yearind` (`ind`),
  ADD KEY `year` (`year`),
  ADD KEY `nivel` (`nivel`),
  ADD KEY `numero` (`numero`),
  ADD KEY `orden` (`orden`),
  ADD KEY `codigo` (`codigo`),
  ADD KEY `visible` (`visible`),
  ADD KEY `materia` (`materia`),
  ADD KEY `grados` (`grados`);

--
-- Indices de la tabla `aspectosIndividuales`
--
ALTER TABLE `aspectosIndividuales`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `docente_2` (`docente`,`grado`,`periodo`,`asignatura`,`nota`),
  ADD KEY `docente` (`docente`),
  ADD KEY `year` (`year`),
  ADD KEY `fecha` (`fecha`);

--
-- Indices de la tabla `codigos`
--
ALTER TABLE `codigos`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `convivencia`
--
ALTER TABLE `convivencia`
  ADD PRIMARY KEY (`ind`),
  ADD KEY `ind` (`ind`),
  ADD KEY `docente` (`docente`),
  ADD KEY `estudiante` (`estudiante`),
  ADD KEY `year` (`year`),
  ADD KEY `fecha` (`fecha`),
  ADD KEY `asignatura` (`asignatura`);

--
-- Indices de la tabla `desempenos`
--
ALTER TABLE `desempenos`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `grado` (`grado`,`asignatura`,`docente`,`periodo`,`desempeno`,`year`),
  ADD KEY `docente` (`docente`);

--
-- Indices de la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD UNIQUE KEY `identificacion_2` (`identificacion`),
  ADD KEY `identificacion` (`identificacion`),
  ADD KEY `identificacion_3` (`identificacion`),
  ADD KEY `asignacion` (`asignacion`),
  ADD KEY `nombres` (`nombres`);

--
-- Indices de la tabla `escalas_1290`
--
ALTER TABLE `escalas_1290`
  ADD PRIMARY KEY (`ind`),
  ADD KEY `year` (`year`);

--
-- Indices de la tabla `estadoNotas`
--
ALTER TABLE `estadoNotas`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `estugrupos`
--
ALTER TABLE `estugrupos`
  ADD UNIQUE KEY `ind_2` (`ind`),
  ADD UNIQUE KEY `estudiante_2` (`estudiante`,`year`),
  ADD KEY `ind` (`ind`),
  ADD KEY `ind_3` (`ind`),
  ADD KEY `estudiante` (`estudiante`),
  ADD KEY `year` (`year`),
  ADD KEY `asignacion` (`asignacion`),
  ADD KEY `nivel` (`nivel`),
  ADD KEY `numero` (`numero`),
  ADD KEY `nombres` (`nombres`),
  ADD KEY `anio` (`anio`);

--
-- Indices de la tabla `estugrupos2`
--
ALTER TABLE `estugrupos2`
  ADD UNIQUE KEY `ind_2` (`ind`),
  ADD UNIQUE KEY `estudiante_2` (`estudiante`,`anio`,`year`),
  ADD KEY `ind` (`ind`),
  ADD KEY `ind_3` (`ind`),
  ADD KEY `estudiante` (`estudiante`),
  ADD KEY `year` (`year`),
  ADD KEY `asignacion` (`asignacion`),
  ADD KEY `nivel` (`nivel`);

--
-- Indices de la tabla `estugrupos3`
--
ALTER TABLE `estugrupos3`
  ADD UNIQUE KEY `ind_2` (`ind`),
  ADD UNIQUE KEY `estudiante_2` (`estudiante`,`anio`,`year`),
  ADD KEY `ind` (`ind`),
  ADD KEY `ind_3` (`ind`),
  ADD KEY `estudiante` (`estudiante`),
  ADD KEY `year` (`year`),
  ADD KEY `asignacion` (`asignacion`),
  ADD KEY `nivel` (`nivel`);

--
-- Indices de la tabla `estugrupos2023`
--
ALTER TABLE `estugrupos2023`
  ADD UNIQUE KEY `ind_2` (`ind`),
  ADD KEY `ind` (`ind`),
  ADD KEY `ind_3` (`ind`),
  ADD KEY `estudiante` (`estudiante`),
  ADD KEY `year` (`year`),
  ADD KEY `asignacion` (`asignacion`),
  ADD KEY `nivel` (`nivel`);

--
-- Indices de la tabla `estugruposALL`
--
ALTER TABLE `estugruposALL`
  ADD PRIMARY KEY (`ind`),
  ADD KEY `estind` (`estudiante`,`director`,`asignacion`,`grupo`);

--
-- Indices de la tabla `excusas`
--
ALTER TABLE `excusas`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD KEY `ind_2` (`ind`),
  ADD KEY `estudiante` (`estudiante`),
  ADD KEY `estudiante_2` (`estudiante`);

--
-- Indices de la tabla `firmas_estudiantes`
--
ALTER TABLE `firmas_estudiantes`
  ADD PRIMARY KEY (`ind`),
  ADD KEY `estudiante` (`estudiante`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `grado` (`grado`,`dia`,`hora`),
  ADD KEY `id_2` (`id`);

--
-- Indices de la tabla `inasistencia`
--
ALTER TABLE `inasistencia`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD UNIQUE KEY `estudiante` (`estudiante`,`materia`,`periodo`,`fecha`,`docente`),
  ADD KEY `ind_2` (`ind`),
  ADD KEY `identificacion` (`estudiante`),
  ADD KEY `estudiante_2` (`estudiante`),
  ADD KEY `materia` (`materia`),
  ADD KEY `year` (`year`),
  ADD KEY `nivel` (`nivel`),
  ADD KEY `numero` (`numero`);

--
-- Indices de la tabla `info_establecimiento`
--
ALTER TABLE `info_establecimiento`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD KEY `ind_2` (`ind`);

--
-- Indices de la tabla `intensidadHoraria`
--
ALTER TABLE `intensidadHoraria`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `itemsConvivencia`
--
ALTER TABLE `itemsConvivencia`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `codind` (`codigo`,`identificacion`);

--
-- Indices de la tabla `mensajeNotas`
--
ALTER TABLE `mensajeNotas`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `noconcedidos`
--
ALTER TABLE `noconcedidos`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `nombresNiveles`
--
ALTER TABLE `nombresNiveles`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `nivel` (`nivel`);

--
-- Indices de la tabla `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD UNIQUE KEY `estudiante_2` (`estudiante`,`grado`,`asignatura`,`docente`,`periodo`,`year`) USING BTREE,
  ADD KEY `ind_2` (`ind`),
  ADD KEY `estudiante` (`estudiante`),
  ADD KEY `docente` (`docente`),
  ADD KEY `asignatura` (`asignatura`),
  ADD KEY `year` (`year`),
  ADD KEY `yearas` (`asignatura`,`year`),
  ADD KEY `year_2` (`year`),
  ADD KEY `periodo` (`periodo`),
  ADD KEY `fechahora` (`fechahora`);

--
-- Indices de la tabla `notas2`
--
ALTER TABLE `notas2`
  ADD KEY `ind` (`ind`),
  ADD KEY `varind` (`estudiante`,`asignatura`,`docente`,`periodo`);

--
-- Indices de la tabla `notascopy`
--
ALTER TABLE `notascopy`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD UNIQUE KEY `estudiante_2` (`estudiante`,`grado`,`asignatura`,`docente`,`periodo`),
  ADD KEY `ind_2` (`ind`),
  ADD KEY `estudiante` (`estudiante`),
  ADD KEY `docente` (`docente`),
  ADD KEY `asignatura` (`asignatura`);

--
-- Indices de la tabla `notasttt`
--
ALTER TABLE `notasttt`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD UNIQUE KEY `estudiante_2` (`estudiante`,`grado`,`asignatura`,`docente`,`periodo`,`year`) USING BTREE,
  ADD KEY `ind_2` (`ind`),
  ADD KEY `estudiante` (`estudiante`),
  ADD KEY `docente` (`docente`),
  ADD KEY `asignatura` (`asignatura`),
  ADD KEY `year` (`year`),
  ADD KEY `yearas` (`asignatura`,`year`),
  ADD KEY `year_2` (`year`),
  ADD KEY `periodo` (`periodo`),
  ADD KEY `fechahora` (`fechahora`);

--
-- Indices de la tabla `notas_backup`
--
ALTER TABLE `notas_backup`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`);

--
-- Indices de la tabla `notas_historico`
--
ALTER TABLE `notas_historico`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `notificacionesLeidas`
--
ALTER TABLE `notificacionesLeidas`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `notifyind_2` (`notifyind`,`docente`),
  ADD KEY `notifyind` (`notifyind`);

--
-- Indices de la tabla `orden_asignaturas`
--
ALTER TABLE `orden_asignaturas`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD KEY `ind_2` (`ind`),
  ADD KEY `asignatura` (`asignatura`),
  ADD KEY `orden` (`orden`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`ind`),
  ADD KEY `idenid` (`identificacion`),
  ADD KEY `nomis` (`nombres`),
  ADD KEY `historid` (`historia`);

--
-- Indices de la tabla `parametros_informe`
--
ALTER TABLE `parametros_informe`
  ADD PRIMARY KEY (`ind`),
  ADD KEY `codigo_materia` (`codigo_materia`),
  ADD KEY `orden` (`orden`),
  ADD KEY `year` (`year`);

--
-- Indices de la tabla `parametros_informe_primaria`
--
ALTER TABLE `parametros_informe_primaria`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `parametros_informe_primaria_5`
--
ALTER TABLE `parametros_informe_primaria_5`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `periodos`
--
ALTER TABLE `periodos`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD KEY `ind_2` (`ind`),
  ADD KEY `fechainicial` (`fechainicial`),
  ADD KEY `fechafinal` (`fechafinal`);

--
-- Indices de la tabla `permisos_docentes`
--
ALTER TABLE `permisos_docentes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `porcentajes_area_colegio`
--
ALTER TABLE `porcentajes_area_colegio`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `asignatura_2` (`asignatura`,`area`,`nivel`,`year`),
  ADD KEY `asignatura` (`asignatura`),
  ADD KEY `year` (`year`),
  ADD KEY `nivel` (`nivel`);

--
-- Indices de la tabla `porcentajes_area_colegio_5`
--
ALTER TABLE `porcentajes_area_colegio_5`
  ADD PRIMARY KEY (`ind`),
  ADD KEY `asignatura` (`asignatura`),
  ADD KEY `year` (`year`),
  ADD KEY `nivel` (`nivel`);

--
-- Indices de la tabla `prueba_estugrupos`
--
ALTER TABLE `prueba_estugrupos`
  ADD UNIQUE KEY `ind_2` (`ind`),
  ADD UNIQUE KEY `estudiante_2` (`estudiante`,`year`),
  ADD KEY `ind` (`ind`),
  ADD KEY `ind_3` (`ind`),
  ADD KEY `estudiante` (`estudiante`),
  ADD KEY `year` (`year`),
  ADD KEY `asignacion` (`asignacion`),
  ADD KEY `nivel` (`nivel`),
  ADD KEY `numero` (`numero`),
  ADD KEY `nombres` (`nombres`),
  ADD KEY `anio` (`anio`);

--
-- Indices de la tabla `reclamo`
--
ALTER TABLE `reclamo`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `estudiante` (`estudiante`,`asignatura`,`fecha`,`nota`),
  ADD KEY `profesor` (`profesor`);

--
-- Indices de la tabla `registrar`
--
ALTER TABLE `registrar`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `identificacion` (`identificacion`),
  ADD UNIQUE KEY `identificacion_2` (`identificacion`,`email`);

--
-- Indices de la tabla `registroIngresos`
--
ALTER TABLE `registroIngresos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `restricciones`
--
ALTER TABLE `restricciones`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD UNIQUE KEY `docente` (`docente`,`dia`,`hora`),
  ADD KEY `ind_2` (`ind`);

--
-- Indices de la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD PRIMARY KEY (`ind`),
  ADD UNIQUE KEY `ind` (`ind`),
  ADD KEY `ind_2` (`ind`);

--
-- Indices de la tabla `seguridad`
--
ALTER TABLE `seguridad`
  ADD PRIMARY KEY (`ind`);

--
-- Indices de la tabla `tdei`
--
ALTER TABLE `tdei`
  ADD PRIMARY KEY (`ind`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `accesos_especiales`
--
ALTER TABLE `accesos_especiales`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `actualizacion`
--
ALTER TABLE `actualizacion`
  MODIFY `ind` bigint(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asignacion_asignaturas`
--
ALTER TABLE `asignacion_asignaturas`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asignacion_asignaturas_old`
--
ALTER TABLE `asignacion_asignaturas_old`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `aspectosIndividuales`
--
ALTER TABLE `aspectosIndividuales`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `codigos`
--
ALTER TABLE `codigos`
  MODIFY `ind` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `convivencia`
--
ALTER TABLE `convivencia`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `desempenos`
--
ALTER TABLE `desempenos`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `escalas_1290`
--
ALTER TABLE `escalas_1290`
  MODIFY `ind` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estadoNotas`
--
ALTER TABLE `estadoNotas`
  MODIFY `ind` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estugrupos`
--
ALTER TABLE `estugrupos`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estugrupos2`
--
ALTER TABLE `estugrupos2`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estugrupos3`
--
ALTER TABLE `estugrupos3`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estugrupos2023`
--
ALTER TABLE `estugrupos2023`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estugruposALL`
--
ALTER TABLE `estugruposALL`
  MODIFY `ind` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `excusas`
--
ALTER TABLE `excusas`
  MODIFY `ind` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `firmas_estudiantes`
--
ALTER TABLE `firmas_estudiantes`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inasistencia`
--
ALTER TABLE `inasistencia`
  MODIFY `ind` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `info_establecimiento`
--
ALTER TABLE `info_establecimiento`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `intensidadHoraria`
--
ALTER TABLE `intensidadHoraria`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `itemsConvivencia`
--
ALTER TABLE `itemsConvivencia`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `log`
--
ALTER TABLE `log`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `matricula`
--
ALTER TABLE `matricula`
  MODIFY `ind` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensajeNotas`
--
ALTER TABLE `mensajeNotas`
  MODIFY `ind` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `ind` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `noconcedidos`
--
ALTER TABLE `noconcedidos`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `nombresNiveles`
--
ALTER TABLE `nombresNiveles`
  MODIFY `ind` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notas`
--
ALTER TABLE `notas`
  MODIFY `ind` bigint(45) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notascopy`
--
ALTER TABLE `notascopy`
  MODIFY `ind` bigint(45) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notasttt`
--
ALTER TABLE `notasttt`
  MODIFY `ind` bigint(45) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notas_backup`
--
ALTER TABLE `notas_backup`
  MODIFY `ind` bigint(45) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notas_historico`
--
ALTER TABLE `notas_historico`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificacionesLeidas`
--
ALTER TABLE `notificacionesLeidas`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `orden_asignaturas`
--
ALTER TABLE `orden_asignaturas`
  MODIFY `ind` bigint(21) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parametros_informe`
--
ALTER TABLE `parametros_informe`
  MODIFY `ind` int(2) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parametros_informe_primaria`
--
ALTER TABLE `parametros_informe_primaria`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parametros_informe_primaria_5`
--
ALTER TABLE `parametros_informe_primaria_5`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permisos_docentes`
--
ALTER TABLE `permisos_docentes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `porcentajes_area_colegio`
--
ALTER TABLE `porcentajes_area_colegio`
  MODIFY `ind` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `porcentajes_area_colegio_5`
--
ALTER TABLE `porcentajes_area_colegio_5`
  MODIFY `ind` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `prueba_estugrupos`
--
ALTER TABLE `prueba_estugrupos`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reclamo`
--
ALTER TABLE `reclamo`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registrar`
--
ALTER TABLE `registrar`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registroIngresos`
--
ALTER TABLE `registroIngresos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `restricciones`
--
ALTER TABLE `restricciones`
  MODIFY `ind` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sedes`
--
ALTER TABLE `sedes`
  MODIFY `ind` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguridad`
--
ALTER TABLE `seguridad`
  MODIFY `ind` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tdei`
--
ALTER TABLE `tdei`
  MODIFY `ind` int(1) NOT NULL AUTO_INCREMENT;
