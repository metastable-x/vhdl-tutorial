# UART Parity

## Project Summary

Building on our UART RX, we add a parity bit to the frame. Now, `uart_top.vhd`, `uart_tx.vhd`, and `uart_rx.vhd` all operate with a `PARITY` string generic. LEDs are used to count the number of parity errors received over RX. 

### Files

| File | Description |
|------|-------------|
| `uart_top.vhd` | Top level file with parity functionality |
| `uart_tx.vhd` | UART transmitter with parity bit generation  |
| `uart_rx.vhd` | UART receiver with parity checking |
| `uart_pkg.vhd` | Package for UART constants and functions |
| `uart.xdc` | Basys3 constraint file |

> **Note:** Be sure to add `uart_pkg.vhd`, `ascii_pkg.vhd`, and `msg_pkg.vhd` from `../rx/`, `btn_debounce.vhd` from `../../db/`, and `seg_driver.vhd` from `../../fifo/` as they're required for bitstream generation.


