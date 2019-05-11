iniciales :: String -> [Char]
iniciales = map inicialDePalabra . words
inicialDePalabra :: String -> Char
inicialDePalabra palabra
  |(length palabra) > 1 = head palabra
  |otherwise = ""