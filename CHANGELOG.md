# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.6.1] - 2025-05-28

### Added
- Initial release of Heimdall Home Assistant Add-on
- Support for HTTP and HTTPS access
- SSL certificate configuration
- Persistent data storage
- Multi-architecture support (armhf, armv7, aarch64, amd64, i386)
- Integration with Home Assistant UI

### Features
- Heimdall v2.6.1 application
- Nginx web server with PHP-FPM
- SQLite database for data persistence
- Configurable ports for HTTP/HTTPS
- SSL/TLS support with custom certificates
- Automatic service management
- Proper permission handling

### Security
- AppArmor support enabled
- Non-privileged container execution
- Secure SSL/TLS configuration
- Proper file permissions

### Documentation
- Complete installation guide
- Configuration options documentation
- Troubleshooting section
- Changelog maintenance

## [Unreleased]

### Planned
- MySQL/MariaDB support
- Backup and restore functionality
- Enhanced logging options
- Custom themes support
- LDAP authentication integration
