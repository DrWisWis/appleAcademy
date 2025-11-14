import Foundation

struct Personagem {
    var nome: String
    var classe: String
    var hp: Int
    var forca: Int
    var magia: Int
    var qi: Int
    var inventario: [String: Int]  // item : quantidade
    
    mutating func atacar(inimigo: inout Inimigo) {
        let dano = Int.random(in: forca/2 ... forca)
        inimigo.hp -= dano
        print("\(nome) atacou \(inimigo.nome) causando \(dano) de dano!")
    }
    
    mutating func usarItem(_ item: String) {
        switch item {
        case "poção":
            if let qtd = inventario["poção"], qtd > 0 {
                hp += 50
                inventario["poção"] = qtd - 1
                print("Você usou uma poção! Vida aumentou para \(hp).")
            } else {
                print("Você não tem poções!")
            }
        default:
            print("Item inválido.")
        }
    }

    mutating func ganharRecompensa() {
        print("""
              
              RECOMPENSAS DA BATALHA
              Você ganhou:
              +1 poção
              +10 de Força
              +10 de HP
              +5 de Inteligência
              """)
        
        inventario["poção", default: 0] += 1
        hp += 10
        forca += 10
        qi += 5
    }
    
    mutating func adiPocao() {
        inventario["poção", default: 0] += 1
    }
}

func atributos(){
    print("Aqui estão seus atributos: ")
    print("Classe: \(jogador.classe)")
    print("Vida: \(jogador.hp)")
    print("forca: \(jogador.forca)")
    print("Inventario: \(jogador.inventario)")
}

struct Inimigo {
    var nome: String
    var hp: Int
    var dano: Int
    
    mutating func atacar(jogador: inout Personagem) {
        let danoCausado = Int.random(in: dano/2 ... dano)
        jogador.hp -= danoCausado
        print("\(nome) atacou você causando \(danoCausado) de dano!")
    }
}


func combate(jogador: inout Personagem, inimigo: inout Inimigo) -> Bool {
    
    print("INÍCIO DO COMBATE CONTRA \(inimigo.nome)!")
    
    while jogador.hp > 0 && inimigo.hp > 0 {
        
        print("""
        
        Sua vida: \(jogador.hp)
        Vida do inimigo: \(inimigo.hp)
        -----------------------------
        O que deseja fazer?
        1 - Atacar
        2 - Usar Poção
        3 - Fugir
        -----------------------------
        """)
        
        if let escolha = readLine() {
            switch escolha {
            case "1":
                jogador.atacar(inimigo: &inimigo)
                
            case "2":
                jogador.usarItem("poção")
                
            case "3":
                print("Você fugiu do combate!")
                return false
                
            default:
                print("Escolha inválida.")
            }
        }
        
        if inimigo.hp > 0 {
            inimigo.atacar(jogador: &jogador)
        }
    }
    
    if jogador.hp <= 0 {
        print("\n Você morreu no combate...")
        return false
    } else {
        print("\n Você derrotou o inimigo!")
        return true
    }
}

func escolherCaminho(jogador: inout Personagem) {
    
    print("""
          
          Agora que venceu a batalha...
          Você pode seguir um caminho!
          
          Escolha:
          1 - Seguir pela caverna escura
          2 - Seguir pela estrada iluminada
          3 - Entrar no bosque silencioso
          """)
    
    if let op = readLine() {
        switch op {
        case "1":
            print("Você entra na caverna... um ar gelado sopra... nada acontece por enquanto.")
        case "2":
            print("A estrada iluminada te leva até uma vila abandonada... você sente que alguém te observa.")
        case "3":
            print("O bosque silencioso dá arrepios... mas você encontra uma erva curativa. +20 HP")
            jogador.hp += 20
        default:
            print("Você ficou parado... nada acontece.")
        }
    }
}

func escolherCaminho2(jogador: inout Personagem) {
    
    print("""
          
          Agora que venceu a batalha...
          Você pode seguir um caminho!
          
          Escolha:
          1 - Seguir para um beco
          2 - Seguir ara um pico de uma montanha nevasca
          3 - Descer direto para uma ravina
          """)
    
    if let op = readLine() {
        switch op {
        case "1":
            print("\nE um novo inimigo aparece!")
            var finalBoss = Inimigo(nome: "Fantasma do Beco Diagonal", hp: 200, dano: 50)
            combate(jogador: &jogador, inimigo: &finalBoss)
            print("Meus parabens Você sobreviveu a zona Oeste(Osasco city)")
        case "2":
            print("\nE um novo inimigo aparece!")
            var finalBoss = Inimigo(nome: "O golem de Neve", hp: 700, dano: 30)
            combate(jogador: &jogador, inimigo: &finalBoss)
            print("Meus parabens Você sobreviveu a zona Oeste(Osasco city)")
        case "3":
            print("\nE um novo inimigo aparece!")
            var finalBoss = Inimigo(nome: "O Morcegão", hp: 150, dano: 70)
            combate(jogador: &jogador, inimigo: &finalBoss)
            print("Meus parabens Você sobreviveu a zona Oeste(Osasco city)")
        default:
            print("Você ficou parado... nada acontece.")
        }
    }
}


func criarPersonagem() -> Personagem {
    print("Escolha sua classe: guerreiro, magico ou bandido")
    
    if let classe = readLine() {
        switch classe {
        case "guerreiro":
            return Personagem(
                nome: "Jogador",
                classe: classe,
                hp: 120,
                forca: 90,
                magia: 10,
                qi: 40,
                inventario: ["poção": 1]
            )
        case "magico":
            return Personagem(
                nome: "Jogador",
                classe: classe,
                hp: 100,
                forca: 20,
                magia: 90,
                qi: 80,
                inventario: ["poção": 2]
            )
        case "bandido":
            return Personagem(
                nome: "Jogador",
                classe: classe,
                hp: 110,
                forca: 60,
                magia: 20,
                qi: 60,
                inventario: ["poção": 1]
            )
        default:
            print("Classe inválida, você virou um MISERÁVEL")
            return Personagem(
                nome: "Jogador",
                classe: "miseravel",
                hp: 90,
                forca: 40,
                magia: 10,
                qi: 20,
                inventario: [:]
            )
        }
    }
    
    return Personagem(nome: "Jogador", classe: "bugado", hp: 100, forca: 10, magia: 10, qi: 10, inventario: [:])
}

print("Bem vindo!!! ELden Ring da Apple no terminal")

var jogador = criarPersonagem()

print(atributos())

print("Pelo inicio da sua jornada por osasco...")
print("Você se depara com o seu primeiro Chefe...")

var boss = Inimigo(nome: "Cabra Sem Cabeça", hp: 150, dano: 25)

if combate(jogador: &jogador, inimigo: &boss) {
    
    jogador.ganharRecompensa()
    
    escolherCaminho(jogador: &jogador)
    
    print("\nE um novo inimigo aparece!")
    
    var lobo = Inimigo(nome: "Lobo Branco", hp: 100, dano: 20)
    
    if combate(jogador: &jogador, inimigo: &lobo) {
        
        jogador.ganharRecompensa()
        
        escolherCaminho2(jogador: &jogador)
    }
}

print("\nFim do jogo!")
