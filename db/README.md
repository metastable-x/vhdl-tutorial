# Debouncers & State Machines

**Video:** [VHDL Tutorial — Debouncers & State Machines ](https://youtu.be/xNhg2-WssuE?si=bXJebbyU7qEvNOo8)

## Project Summary

In this video, we create a debouncer circuit using a state machine and verify it using the Basys3 7-segment display. The buttons on the Basys3 are analog and suseptible to noise. A debouncer can be used to verify the input from our button so that we only count one press every time the button is pushed. A state machine is a structure we can use to organize our logic. 

### Files

| File | Description |
|------|-------------|
| `btn_counter.vhd` | Top level file for button counter |
| `btn_debouncer.vhd` | Button debouncer circuit |
| `btn_counter.xdc` | Button counter contraint file |

## Edits Made

| Date | Change | Reason |
|------|--------|--------|
| Initial release | The states idle and pressed are no longer capitalized | Stylization and clarity |