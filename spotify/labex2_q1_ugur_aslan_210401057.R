# labex2_q1_studentnumber_surname_familyname.R
library(httr)

client_id <- "your_id"
client_secret <- "your_secret"

# Spotify Web API'ye yetkilendirme talebi için fonksiyon
spotify_token <- function() {
  # Spotify Web API için token talebi URL'i
  token_endpoint <- "https://accounts.spotify.com/api/token"
  
  # Token talebi için gerekli parametreler
  token_params <- list(
    grant_type = "client_credentials"
  )
  
  # Token talebi yap
  token_response <- POST(token_endpoint,
                         authenticate(client_id, client_secret),
                         body = token_params,
                         encode = "form")
  (token_response)
  
  # HTTP status kodu
  status_code <- status_code(token_response)
  (status_code)
  
  # Token
  token <- paste("Bearer", content(token_response)$access_token)
  
  # Sonuçları liste olarak döndür
  result <- list(status_code = status_code, token = token)
  return(result)
}

# Fonksiyonu çağır ve sonucu yazdır
result <- spotify_token()
cat("Status Code:", result$status_code, "\n")
cat("Token:", result$token, "\n")
cat("end_point:", result$end_point, "\n")

