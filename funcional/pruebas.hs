-- iniciales :: String -> String
iniciales oracion = map inicialDePalabra (words oracion)
inicialDePalabra :: String -> Char
inicialDePalabra palabra
    |(length palabra) > 1 = head palabra