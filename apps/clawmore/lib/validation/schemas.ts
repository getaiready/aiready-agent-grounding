import { z } from 'zod';

// GitHub repo name: alphanumeric, hyphens, underscores, 1-100 chars
const repoNameSchema = z
  .string()
  .min(1, 'Repo name is required')
  .max(100, 'Repo name too long')
  .regex(
    /^[a-zA-Z0-9_-]+$/,
    'Repo name can only contain letters, numbers, hyphens, and underscores'
  );

// Email validation
const emailSchema = z
  .string()
  .email('Invalid email address')
  .max(254, 'Email too long');

// User name: printable characters, 1-100 chars
const userNameSchema = z
  .string()
  .min(1, 'User name is required')
  .max(100, 'User name too long')
  .regex(/^[\p{L}\p{N}\s._-]+$/u, 'User name contains invalid characters');

export const ProvisionRequestSchema = z.object({
  userEmail: emailSchema,
  userName: userNameSchema,
  repoName: repoNameSchema,
  coEvolutionOptIn: z.boolean().optional().default(false),
});

export const CreateManagedAccountSchema = z.object({
  userEmail: emailSchema,
  userName: userNameSchema,
});
