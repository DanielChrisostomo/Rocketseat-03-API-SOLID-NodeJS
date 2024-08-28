import { FastifyInstance } from 'fastify';
import { register } from './controllers/register-controller';
import { authenticate } from '@/http/controllers/authenticate-controller';
import { profile } from '@/http/controllers/profile-controller'
import { verifyJwt } from '@/http/middlewares/verify-jwt';

export async function appRoutes(app: FastifyInstance) {
    app.post('/users', register)
    app.post('/sessions', authenticate)
    app.get('/me', { onRequest: [verifyJwt] }, profile)
}

