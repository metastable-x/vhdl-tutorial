# UART RX

**Video:** [VHDL Tutorial — UART: RX](https://youtu.be/bi-zz-XorMY?si=LWbz3-71plvCeMsg)

## Project Summary

Building on our UART transmitter, we now add a receiver. This additon allows us to receive text from a PuTTY terminal and echo it back and send multiple message using a message selector with the 7-segment display shows the currently message. The top level and controller have been updated to handle both TX and RX transactions.

### Files

| File | Description |
|------|-------------|
| `uart_top.vhd` | Top level file for our UART system |
| `uart_rx.vhd` | UART receiver block |
| `uart_ctrl.vhd` | Updated UART controller |
| `ascii_pkg.vhd` | ASCII conversion package |
| `msg_pkg.vhd` | TX message package |
| `uart.xdc` | Basys3 constraint file |

> **Note:** Be sure to add `uart_tx.vhd` from `../tx/`, `btn_debounce.vhd` from `../../db/`, and `seg_driver.vhd` from `../../fifo/` as they're required for bitstream generation.

| Date | Change | Reason |
|------|--------|--------|
| 7/7/26 | `btn`->`send` <br> `msg_sel`->`tx_sel` <br> `msg_max`->`ptr_max` | To add more clarity to the design. |


