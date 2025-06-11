//
//  UtilidadesJson.swift
//  OBD Reader
//
//  Created by administrador on 9/6/25.
//
 
import Foundation
 
/// Abre un arquivo do proxecto e carga os seus datos.
///
/// Esta función busca un arquivo dentro do `Bundle.main` utilizando o seu nome e extensión.
/// Se o arquivo existe, carga o seu contido como `Data`. En caso contrario, detén a execución con `fatalError()`.
///
/// - Parameter nomeArquivo: Nome do arquivo dentro do proxecto (sen extensión).
/// - Returns: Os datos do arquivo en formato `Data`, ou `nil` se a carga falla.
/// - Warning: Esta función usa `fatalError()`, polo que a aplicación fallará se o arquivo non se atopa ou non se pode cargar.
///
/// - Example:
/// ```swift
/// if let datos = abrirArquivo(nomeArquivo: "datos.json") {
///     print("Arquivo cargado con éxito")
/// }
/// ```
func abrirArquivo(nomeArquivo: String) -> Data? {
    var datos: Data
     
    // Busca o arquivo dentro do bundle da aplicación
    guard let arquivo = Bundle.main.url(forResource: nomeArquivo,
                                  withExtension: nil)
    else {
        fatalError("\(nomeArquivo) non atopado no proxecto.")
    }
      
    do {
        // Intenta cargar os datos do arquivo
        datos = try Data(contentsOf: arquivo)
    } catch {
        fatalError("Non foi posible cargar o arquivo \(nomeArquivo): \(error)")
    }
    return datos
}
 
/// Descarga e carga os datos dun arquivo desde unha URL.
///
/// Esta función intenta descargar os datos dun arquivo situado nunha URL remota ou local.
/// Se a descarga é exitosa, devolve os datos en formato `Data`. En caso de erro, imprime unha mensaxe e devolve `nil`.
///
/// - Parameter url: A URL do arquivo que se desexa descargar.
/// - Returns: Os datos do arquivo en formato `Data`, ou `nil` se a descarga falla.
///
/// - Example:
/// ```swift
/// if let url = URL(string: "https://exemplo.com/arquivo.json"),
///    let datos = abrirArquivo(url: url) {
///     print("Arquivo descargado con éxito, tamaño: \(datos.count) bytes")
/// }
/// ```
func abrirArquivo(url: URL) -> Data? {
    do {
        // Intenta descargar e cargar os datos do arquivo na URL fornecida
        let data = try Data(contentsOf: url)
        return data
    } catch {
        // Se ocorre un erro, imprímeo e devolve `nil`
        print("Erro ao descargar o arquivo: \(error)")
        return nil
    }
}
 
 
/// Decodifica un arquivo JSON nunha estrutura específica.
///
/// Esta función toma datos en formato `Data` e intenta decodificalos nunha estrutura que cumpra o protocolo `Decodable`.
/// Se a decodificación falla, a execución deterase con `fatalError()`.
///
/// - Parameter arquivo: Os datos en formato `Data` que conteñen o JSON.
/// - Returns: Unha instancia de `TipoEstrutura`, que é un tipo xenérico que implementa `Decodable`.
/// - Throws: Non lanza erros explicitamente, pero usa `fatalError()` en caso de fallo.
/// - Warning: Se hai un erro ao procesar o JSON, a aplicación deterase.
/// - Note: Esta función só funciona con tipos que cumpren `Decodable`.
///
/// - Example:
/// ```swift
/// struct Usuario: Decodable {
///     let nome: String
///     let idade: Int
/// }
///
/// let jsonData = """
/// {
///     "nome": "Diego",
///     "idade": 46
/// }
/// """.data(using: .utf8)!
///
/// let usuario: Usuario = procesarJSON(arquivo: jsonData)
/// print(usuario.nome) // "Diego"
/// ```
 
/*
 📌 Que é TipoEstrutura: Decodable?
 
 TipoEstrutura é un parámetro de tipo xenérico. Significa que esta función pode traballar con calquera tipo de datos, sempre que cumpra cunha determinada restrición.
     •    TipoEstrutura → É un tipo de datos que será determinado cando se chame á función.
     •    : Decodable → Indica que TipoEstrutura debe cumprir o protocolo Decodable. É dicir, debe ser un tipo que poida ser decodificado desde JSON.
  
 📌 Resumo
 
 ✅ <TipoEstrutura: Decodable> fai que a función sexa xerérica, podendo aceptar calquera tipo que cumpra Decodable.
 ✅ Permite reutilizar a mesma función para diferentes estruturas de datos sen escribir código duplicado.
 ✅ Evita o uso de tipos específicos e fai que o código sexa máis flexible e escalable. 🚀
  
*/
func procesarJSON(arquivo: Data) -> [CocheModel] {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601

    do {
        let coches = try decoder.decode([CocheModel].self, from: arquivo)
        return coches
    } catch {
        fatalError("Non foi posible parsear o arquivo: \(error)")
    }
}

