<?php

namespace FactelBundle\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;


use FactelBundle\Entity\Factura;
use FactelBundle\Entity\Cliente;
use FactelBundle\Entity\Emisor;
use FactelBundle\Entity\Establecimiento;
use FactelBundle\Entity\PtoEmision;
use FactelBundle\Entity\FacturaHasProducto;
use FactelBundle\Entity\Impuesto;
use FactelBundle\Entity\PlanCtas;
use FactelBundle\Entity\CampoAdicional;
use FactelBundle\Form\FacturaType;
use FactelBundle\Form\ClienteType;
use JMS\SecurityExtraBundle\Annotation\Secure;
use Symfony\Component\HttpFoundation\Response;
use FactelBundle\Util;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;




/**
 * PlanCtas controller.
 *
 * @Route("/planctas")
 */
class PlanCtasController extends Controller
{

    /**
     * Lists all Emisor entities.
     *
     * @Route("/a", name="inicio")
     * 
     * @Method("GET")
     */
    public function indexAction() {

        $personas = $this->getDoctrine()
                    ->getRepository(PlanCuentas::class)
                    ->findCuentas();

        return $this->render('FactelBundle:PlanCtas:index.html.twig',array(
            'valor'=>$personas
        ));
    }
}
