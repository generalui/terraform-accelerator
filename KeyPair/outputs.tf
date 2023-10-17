output "key_name" {
  value       = module.key_pair.key_name
  description = "Name of SSH key"
}

output "public_key" {
  value       = module.key_pair.public_key
  description = "Content of the generated public key"
}

output "private_key" {
  sensitive   = true
  description = "Content of the generated private key"
  value       = module.key_pair.private_key
}

output "public_key_filename" {
  description = "Public Key Filename"
  value       = module.key_pair.public_key_filename
}

output "private_key_filename" {
  description = "Private Key Filename"
  value       = module.key_pair.private_key_filename
}
