# D Flip-Flop

**Video:** [VHDL Tutorial — D Flip-Flop](https://youtu.be/vlOOXiz_S4w?si=zQz1tqwY-BcUk3el)

## Project Summary

For this video, we build one of the most foundational components of an FPGA, a D flip flop, and verify it with a testbench. D flip-flops take in a clock and a one bit data input and returns the same data input after a small delay. This output is usable by the rest of the system on the next clock edge. D flip flops can be used to pipline our designs or like registers to store data. D flip-flops can be chained together to hold multiple bits of data.

### Files

| File | Description |
|------|-------------|
| `dff.vhd` | D flip-flop with synchronous reset |
| `dff_tb.vhd` | Simple testbench for the D flip-flop|