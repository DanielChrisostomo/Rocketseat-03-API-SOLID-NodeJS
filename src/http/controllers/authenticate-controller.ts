import { FastifyRequest, FastifyReply } from 'fastify'
import { z } from 'zod'
import { PrismaUsersRepository } from '@/repositories/prisma/prisma-users-repository' 
import { InvalidCredentialsError } from '@/use-cases/errors/invalid-credentials-error'
import { AuthenticateUseCase } from '@/use-cases/authenticate'
import { makeAuthenticateUseCase } from '@/use-cases/factories/make-authenticate-use-case'

export async function authenticate (request: FastifyRequest, reply: FastifyReply) {
    const authenticateBodySchema = z.object({
        email: z.string().email(),
        password: z.string().min(6)
    })

    const { email, password } = authenticateBodySchema.parse(request.body)

    try {
        const authenticateUseCase = makeAuthenticateUseCase()

        await authenticateUseCase.execute({ email, password })
        
    } catch (error) {
        if (error instanceof InvalidCredentialsError) {
            reply.status(400).send({ message: error.message })
        }

        throw error
    }

    return reply.status(200).send()
}