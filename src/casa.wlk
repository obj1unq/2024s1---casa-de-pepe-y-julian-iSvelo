object casaDePepeYJulian {

	var estrategiaDeAhorro = minimoEIndispensable
	var property viveresDeCasa = 50
	var property montoDeReparaciones = 0
	var cuentaParaGastos = cuentaCorriente

	method agregarViveres(cantidad) {
		viveresDeCasa += cantidad
	}

	method estrategiaDeAhorro(_estrategiaDeAhorro) {
		estrategiaDeAhorro = _estrategiaDeAhorro
	}

	method mantenimiento() {
		estrategiaDeAhorro.hacerMantenimiento(self)
	}

	method gastoDeCasa(valor) {
		cuentaParaGastos.extraer(valor)
	}

	method cuentaParaGastos(_cuentaParaGastos) {
		cuentaParaGastos = _cuentaParaGastos
	}

	method sumarAlMontoDeReparacion(valor) {
		montoDeReparaciones += valor
	}

	method tieneViveresSuficientes() {
		return 40 < viveresDeCasa
	}

	method hayQueReparar() {
		return montoDeReparaciones > 0
	}

	method casaEnOrden() {
		return self.tieneViveresSuficientes() && self.hayQueReparar().negate()
	}

	method tieneSaldoParaReparaciones() {
		return montoDeReparaciones < cuentaParaGastos.saldo()
	}

	method sobranMasDe1000() {
		return cuentaParaGastos.saldo() - montoDeReparaciones >= 1000
	}

}

object cuentaCorriente {

	var saldo = 0

	method saldo() {
		return saldo
	}

	method extraer(valor) {
		saldo -= valor
	}

	method depositar(valor) {
		saldo = saldo + valor
	}

}

object cuentaConGastos {

	var saldo = 0
	var costoDeOperacion = 0

	method saldo() {
		return saldo
	}

	method extraer(valor) {
		saldo -= valor
	}

	method costoDeOperacion(_costoDeOperacion) {
		costoDeOperacion = _costoDeOperacion
	}

	method depositar(valor) {
		saldo = saldo + valor - costoDeOperacion
	}

}

object cuentaCombinada {

	var cuentaPrimaria = cuentaCorriente
	var cuentaSecundaria = cuentaCorriente

	method saldo() {
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	}

	method cuentaPrimaria(_cuentaPrimaria) {
		cuentaPrimaria = _cuentaPrimaria
	}

	method cuentaSecundaria(_cuentaSecundaria) {
		cuentaSecundaria = _cuentaSecundaria
	}

	method extraer(valor) {
		if (self.cuentaPrimariaTieneSaldoSuficiente(valor)) {
			cuentaPrimaria.extraer(valor)
		} else cuentaSecundaria.extraer(valor)
	}

	method cuentaPrimariaTieneSaldoSuficiente(valor) {
		return cuentaPrimaria.saldo() > valor
	}

	method depositar(valor) {
		cuentaPrimaria.depositar(valor)
	}

}

object minimoEIndispensable {

	var calidad = 1

	method calidad(_calidad) {
		calidad = _calidad
	}

	method hacerMantenimiento(casa) {
		if (casa.tieneViveresSuficientes().negate()) {
			casa.gastoDeCasa(self.gastoPorViveres(casa))
			casa.viveresDeCasa(40)
		}
	}

	method gastoPorViveres(casa) {
		return (40 - casa.viveresDeCasa()) * calidad
	}

}

object full {

	const calidad = 5
	const gastoPor40DeViveres = 40 * 5

	method gastoPorViveres(casa) {
		return (100 - casa.viveresDeCasa()) * calidad
	}

	method repararacionDeCasa(casa) {
		if (casa.tieneSaldoParaReparaciones() and casa.sobranMasDe1000()) {
			casa.gastoDeCasa(casa.montoDeReparaciones())
			casa.montoDeReparaciones(0)
		}
	}

	method hacerMantenimiento(casa) {
		self.gastosDeCasaEnMantenimiento(casa)
		self.repararacionDeCasa(casa)
	}

	method gastosDeCasaEnMantenimiento(casa) {
		if (casa.casaEnOrden()) {
			casa.gastoDeCasa(self.gastoPorViveres(casa))
			casa.viveresDeCasa(100)
		} else {
			casa.gastoDeCasa(gastoPor40DeViveres)
			casa.agregarViveres(40)
		}
	}

}

