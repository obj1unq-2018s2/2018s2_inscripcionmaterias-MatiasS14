class Materia {
	const property curso
	
	var property cupos
	
	var property alumnosInscriptos= #{}
	
	var property listaDeEspera=#{}
	
	var property materiasCorrelativas
	
	var property creditosAlAprobar
	
	var property anioMateria
	
	var property creditosNecesarios		
	
	method perteneceACarrera(carrera) = carrera.materiasDeLaCarrera().contains(self)
	
	method puedeInscribirse(estudiante)=  estudiante.cumpleMateriasCorrelativas(self)  and estudiante.tieneCreditosSuficientes(self) and estudiante.aproboMateriasDeAnio(anioMateria-1)
	
	method haySobrecupo()= cupos <= alumnosInscriptos.size()
	
	method inscribirAlumno(estudiante){ alumnosInscriptos.add(estudiante) }
	
	method alumnoAListaDeEspera(estudiante){ listaDeEspera.add(estudiante) }
	
	method darDeBajaAlumno(estudiante){
		
		if( ! listaDeEspera.isEmpty() ){
			
			alumnosInscriptos.remove(estudiante)
			alumnosInscriptos.add( listaDeEspera.first() )
			listaDeEspera.remove( listaDeEspera.first() )
		}
		else{
			alumnosInscriptos.remove(estudiante)
		}
	}
	
		
}

class MateriaAprobada{
	const property materia
	const property nota
}
