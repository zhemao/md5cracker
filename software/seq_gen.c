#include "seq_gen.h"

void init_seq_gen(struct seq_gen *seq_gen)
{
	int i;

	seq_gen->length = 0;

	for (i = 0; i < 26; i++) {
		seq_gen->valid_chars[i] = 'a' + i;
		seq_gen->valid_chars[i + 26] = 'A' + i;
	}

	for (i = 0; i < 10; i++)
		seq_gen->valid_chars[i + 52] = '0' + i;
}

static inline void copy_sequence(struct seq_gen *seq_gen, uint8_t *seq)
{
	int i;
	for (i = 0; i < seq_gen->length; i++)
		seq[i] = seq_gen->valid_chars[seq_gen->sequence[i]];
}

int next_sequence(struct seq_gen *seq_gen, uint8_t *seq)
{
	int i;
	char last_char = NUM_VALID_CHARS - 1;
	int updated = 0;

	for (i = 0; i < seq_gen->length; i++) {
		if (seq_gen->sequence[i] != last_char) {
			seq_gen->sequence[i]++;
			updated = 1;
			break;
		}
		seq_gen->sequence[i] = 0;
	}

	if (!updated) {
		if (seq_gen->length == LARGEST_SEQUENCE)
			return 0;
		seq_gen->sequence[seq_gen->length] = 0;
		seq_gen->length++;
	}

	copy_sequence(seq_gen, seq);
	return seq_gen->length;
}
