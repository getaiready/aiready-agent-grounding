import { describe, it, expect, vi } from 'vitest';
import { AGENT_GROUNDING_PROVIDER } from '../provider';
import { validateSpokeOutput } from '@aiready/core';

// Mock core functions to avoid actual FS access
vi.mock('@aiready/core', async (importOriginal) => {
  const actual = await importOriginal<typeof import('@aiready/core')>();
  return {
    ...actual,
    scanFiles: vi.fn().mockResolvedValue(['file1.ts', 'README.md']),
    readFileContent: vi.fn().mockImplementation((file) => {
      if (file === 'file1.ts') return 'export const x = 1;';
      if (file === 'README.md') return '# Test Project';
      return '';
    }),
    isDirectory: vi.fn().mockReturnValue(false),
    exists: vi.fn().mockReturnValue(true),
  };
});

describe('Agent Grounding Contract Validation', () => {
  it('should produce output matching the SpokeOutput contract', async () => {
    const options = {
      rootDir: './test',
      include: ['*.ts'],
      exclude: [],
    };

    const output = await AGENT_GROUNDING_PROVIDER.analyze(options);

    // 1. Structural Validation
    const validation = validateSpokeOutput('agent-grounding', output);
    if (!validation.valid) {
      console.error('Contract Validation Errors:', validation.errors);
    }
    expect(validation.valid).toBe(true);

    // 2. Scoring Validation
    const score = AGENT_GROUNDING_PROVIDER.score(output, options);
    expect(score).toBeDefined();
    expect(typeof score.score).toBe('number');
    expect(score.score).toBeGreaterThanOrEqual(0);
    expect(score.score).toBeLessThanOrEqual(100);
    expect(Array.isArray(score.recommendations)).toBe(true);
  });
});
